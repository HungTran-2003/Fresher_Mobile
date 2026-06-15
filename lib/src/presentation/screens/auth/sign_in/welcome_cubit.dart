import 'package:equatable/equatable.dart';
import 'package:finance/src/core/utils/extensions/either_extension.dart';
import 'package:finance/src/domain/models/enum/load_status.dart';
import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:finance/src/presentation/global/auth/auth_cubit.dart';
import 'package:finance/src/presentation/global/user/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_navigator.dart';
part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final AuthCubit _authCubit;
  final UserCubit _userCubit;
  final AuthRepository _authRepository;
  final WelcomeNavigator navigator;

  WelcomeCubit({
    required AuthCubit authCubit,
    required AuthRepository authRepository,
    required UserCubit userCubit,
    required this.navigator,
  }) : _authCubit = authCubit,
       _authRepository = authRepository,
       _userCubit = userCubit,
       super(WelcomeState());

  Future<void> logIn(String email, String password) async {
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await _authRepository.logIn(
      email: email,
      password: password,
    );
    await result.foldResult(
      onError: (failure) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      onSuccess: (user) {
        _userCubit.updateUser(user);
        biometricLogIn();
      },
    );
  }

  Future<void> logInWithGoogle() async {
    if (state.status == LoadStatus.loading) return;
    emit(state.copyWith(status: LoadStatus.loading));
    final result = await _authRepository.signInWithGoogle();
    result.foldResult(
      onError: (failure) {
        emit(state.copyWith(status: LoadStatus.failure));
        navigator.showErrorDialog(message: failure.message);
      },
      onSuccess: (user) {
        _userCubit.updateUser(user);
        biometricLogIn();
      },
    );
  }

  void biometricLogIn() {
    _authCubit.setAuthenticated(true);
    emit(state.copyWith(status: LoadStatus.success));
  }
}
