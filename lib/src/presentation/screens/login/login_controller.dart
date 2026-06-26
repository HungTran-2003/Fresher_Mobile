import 'package:crud_app/generated/l10n.dart';
import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/usecases/auth/get_last_login_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/login_use_case.dart';
import 'package:crud_app/src/domain/usecases/auth/relogin_use_case.dart';
import 'package:crud_app/src/domain/usecases/setting/setting_use_cases.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:crud_app/src/presentation/global/auth/auth_controller.dart';
import 'package:crud_app/src/presentation/global/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'login_navigator.dart';
import 'login_state.dart';

class LoginController extends GetxController {
  final AuthController _authController;
  final UserController _userController;
  final LoginUseCase _loginUseCase;
  final GetLastLoginUseCase _getLastLoginUseCase;
  final GetBiometricsUseCase _getBiometricsUseCase;
  final ReloginUseCase _reloginUseCase;
  final LoginNavigator navigator;

  final state = LoginState();

  final TextEditingController taxIdOrIdController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController({
    required AuthController authController,
    required UserController userController,
    required LoginUseCase loginUseCase,
    required GetLastLoginUseCase getLastLoginUseCase,
    required GetBiometricsUseCase getBiometricsUseCase,
    required ReloginUseCase reloginUseCase,
    required this.navigator,
  }) : _authController = authController,
       _userController = userController,
       _loginUseCase = loginUseCase,
       _getLastLoginUseCase = getLastLoginUseCase,
       _reloginUseCase = reloginUseCase,
       _getBiometricsUseCase = getBiometricsUseCase;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    taxIdOrIdController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> init() async {
    final result = await _getLastLoginUseCase(NoParams());
    final useBio = await _getBiometricsUseCase();
    await result.foldResult(
      onError: (_) {},
      onSuccess: (data) {
        taxIdOrIdController.text = data['taxIdOrId'] ?? '';
        usernameController.text = data['username'] ?? '';
        state.taxIdOrId.value = data['taxIdOrId'] ?? '';
        state.username.value = data['username'] ?? '';
        state.useBiometrics.value = useBio;
        if (useBio) {
          loginWithBiometrics();
        }
      },
    );
  }

  void onTaxIdOrIdChanged(String value) => state.taxIdOrId.value = value;
  void onUsernameChanged(String value) => state.username.value = value;
  void onPasswordChanged(String value) => state.password.value = value;
  void changeIsFirstSubmit(bool value) => state.isFirstSubmit.value = value;

  Future<void> submitLogin() async {
    state.status.value = LoadStatus.loading;
    final result = await _loginUseCase(LoginParams(
      taxIdOrId: state.taxIdOrId.value.trim(),
      username: state.username.value.trim(),
      password: state.password.value,
    ));

    result.fold(
      ifLeft: (failure) {
        state.status.value = LoadStatus.failure;
        navigator.showErrorDialog(message: failure.message);
      },
      ifRight: (account) async {
        final user = UserEntity(
          id: account.taxIdOrId,
          userName: account.username,
          email: '',
          fullName: account.fullName,
        );
        _userController.updateUser(user);
        _authController.setAuthenticated(true);

        state.status.value = LoadStatus.success;
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
        final taxId = state.taxIdOrId.value;
        final username = state.username.value;

        if (taxId.isEmpty || username.isEmpty) {
          state.status.value = LoadStatus.failure;
          navigator.showErrorDialog(message: S.current.loginErrorTitle);
          return;
        }

        await _userController.getUser(taxId, username);
        await _reloginUseCase();
        _authController.setAuthenticated(true);
      }
    }
  }
}
