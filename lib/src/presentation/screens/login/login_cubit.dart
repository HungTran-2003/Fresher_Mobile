import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'package:crud_app/src/domain/repositories/setting_repository.dart';
import 'package:local_auth/local_auth.dart';
import 'login_navigator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final AuthRepository _authRepository;
  final SettingRepository _settingRepository;
  final LoginNavigator navigator;

  LoginCubit({
    required AuthCubit authCubit,
    required UserCubit userCubit,
    required AuthRepository authRepository,
    required SettingRepository settingRepository,
    required this.navigator,
  }) : _authCubit = authCubit,
       _userCubit = userCubit,
       _authRepository = authRepository,
       _settingRepository = settingRepository,
       super(const LoginState());

  final TextEditingController taxIdOrIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Future<void> close() {
    taxIdOrIdController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }

  Future<void> init() async {
    final result = await _authRepository.getLastLogin();
    final useBio = await _settingRepository.getUseBiometrics();
    await result.foldResult(
      onError: (_) {},
      onSuccess: (data) {
        taxIdOrIdController.text = data['taxIdOrId'] ?? '';
        usernameController.text = data['username'] ?? '';
        emit(
          state.copyWith(
            taxIdOrId: data['taxIdOrId'] ?? '',
            username: data['username'] ?? '',
            useBiometrics: useBio,
          ),
        );
      },
    );
    if(useBio){
      await loginWithBiometrics();
    }
  }

  void onTaxIdOrIdChanged(String value) {
    emit(state.copyWith(taxIdOrId: value));
  }

  void onUsernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> submitLogin() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await _authRepository.login(
      taxIdOrId: state.taxIdOrId.trim(),
      username: state.username.trim(),
      password: state.password,
    );

    result.fold(
      ifLeft: (failure) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      ifRight: (account) async {
        final user = UserEntity(
          id: account.taxIdOrId,
          userName: account.username,
          email: '',
          fullName: account.fullName,
        );
        _userCubit.updateUser(user);
        _authCubit.setAuthenticated(true);

        emit(state.copyWith(status: LoadStatus.success));
        navigator.toHome();
      },
    );
  }

  Future<void> loginWithBiometrics() async {
    final localAuth = LocalAuthentication();
    final isSupported = await localAuth.isDeviceSupported();
    final canCheck = await localAuth.canCheckBiometrics;

    if (isSupported && canCheck) {
      final authenticated = await localAuth.authenticate(
        localizedReason: S.current.biometricLoginTitle,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        final taxId = state.taxIdOrId;
        final username = state.username;

        if (taxId.isEmpty || username.isEmpty) {
          emit(state.copyWith(status: LoadStatus.failure));
          navigator.showErrorDialog(message: S.current.loginErrorTitle);
        }

        await _userCubit.getUser(taxId, username);
        _authCubit.setAuthenticated(true);
        navigator.toHome();
      }
    }
  }

  void changeIsFirstSubmit(bool value) {
    emit(state.copyWith(isFirstSubmit: value));
  }
}
