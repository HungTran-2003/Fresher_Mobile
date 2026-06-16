import 'package:crud_app/src/core/utils/extensions/either_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'package:crud_app/src/domain/models/entities/user_entity.dart';
import 'package:crud_app/src/presentation/global/auth/auth_cubit.dart';
import 'package:crud_app/src/presentation/global/user/user_cubit.dart';
import 'package:crud_app/src/domain/repositories/auth_repository.dart';
import 'login_navigator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final AuthRepository _authRepository;
  final LoginNavigator navigator;

  LoginCubit({
    required AuthCubit authCubit,
    required UserCubit userCubit,
    required AuthRepository authRepository,
    required this.navigator,
  })  : _authCubit = authCubit,
        _userCubit = userCubit,
        _authRepository = authRepository,
        super(const LoginState());

  void onTaxIdOrIdChanged(String value) {
    emit(state.copyWith(taxIdOrId: value));
  }

  void onUsernameChanged(String value) {
    emit(state.copyWith(username: value));
  }

  void onPasswordChanged( String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> submitLogin() async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await _authRepository.login(
      taxIdOrId: state.taxIdOrId,
      username: state.username,
      password: state.password,
    );

    return result.foldResult(
      onError: (failure) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      onSuccess: (account) {
        final user = UserEntity(
          id: '1',
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

  void changeIsFirstSubmit(bool value) {
    emit(state.copyWith(isFirstSubmit: value));
  }
}
