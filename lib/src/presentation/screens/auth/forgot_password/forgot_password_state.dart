enum ForgotPasswordStatus { initial, loading, success, failure }

enum ForgotPasswordStep { email, pin, newPassword }

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final ForgotPasswordStep step;
  final String email;
  final String pin;
  final String newPassword;
  final String confirmPassword;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? errorMessage;
  final String? successMessage;

  const ForgotPasswordState({
    required this.status,
    required this.step,
    this.email = '',
    this.pin = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage,
    this.successMessage,
  });

  factory ForgotPasswordState.initial() {
    return const ForgotPasswordState(
      status: ForgotPasswordStatus.initial,
      step: ForgotPasswordStep.email,
    );
  }

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    ForgotPasswordStep? step,
    String? email,
    String? pin,
    String? newPassword,
    String? confirmPassword,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
    String? successMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      step: step ?? this.step,
      email: email ?? this.email,
      pin: pin ?? this.pin,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
