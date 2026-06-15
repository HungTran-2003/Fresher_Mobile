import 'package:finance/src/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_navigator.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;
  final ForgotPasswordNavigator navigator;

  ForgotPasswordCubit({
    required AuthRepository authRepository,
    required this.navigator,
  })  : _authRepository = authRepository,
        super(ForgotPasswordState.initial());

  void updateEmail(String email) {
    emit(state.copyWith(email: email, errorMessage: null));
  }

  void updatePin(String pin) {
    emit(state.copyWith(pin: pin, errorMessage: null));
  }

  void updateNewPassword(String newPassword) {
    emit(state.copyWith(newPassword: newPassword, errorMessage: null));
  }

  void updateConfirmPassword(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword, errorMessage: null));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void changeStep(ForgotPasswordStep step) {
    emit(state.copyWith(step: step, errorMessage: null));
  }

  Future<void> sendVerificationCode() async {
    if (state.email.isEmpty) return;
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _authRepository.resetPassword(state.email);
      emit(state.copyWith(
        status: ForgotPasswordStatus.initial,
        step: ForgotPasswordStep.pin,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> verifyPin() async {
    if (state.pin.length < 6) return;
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      // Simulate API call to verify PIN
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(
        status: ForgotPasswordStatus.initial,
        step: ForgotPasswordStep.newPassword,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> resendPin() async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      emit(state.copyWith(
        status: ForgotPasswordStatus.initial,
        successMessage: 'resendPinSuccess',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> resetPassword() async {
    if (state.newPassword.isEmpty || state.confirmPassword.isEmpty) return;
    if (state.newPassword != state.confirmPassword) return;

    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await _authRepository.updatePassword(state.newPassword);
      emit(state.copyWith(status: ForgotPasswordStatus.success));
      navigator.back(); // Pop back to Welcome
    } catch (e) {
      emit(state.copyWith(
        status: ForgotPasswordStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void handleBackPress() {
    switch (state.step) {
      case ForgotPasswordStep.email:
        navigator.back();
        break;
      case ForgotPasswordStep.pin:
        emit(state.copyWith(step: ForgotPasswordStep.email));
        break;
      case ForgotPasswordStep.newPassword:
        emit(state.copyWith(step: ForgotPasswordStep.pin));
        break;
    }
  }
}
