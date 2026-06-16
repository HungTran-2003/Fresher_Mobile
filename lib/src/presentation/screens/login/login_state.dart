part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus status;
  final bool isFirstSubmit;
  final String taxIdOrIdError;
  final String usernameError;
  final String passwordError;
  final String generalError;

  const LoginState({
    this.status = LoadStatus.initial,
    this.isFirstSubmit = false,
    this.taxIdOrIdError = '',
    this.usernameError = '',
    this.passwordError = '',
    this.generalError = '',
  });

  LoginState copyWith({
    LoadStatus? status,
    bool? isFirstSubmit,
    String? taxIdOrIdError,
    String? usernameError,
    String? passwordError,
    String? generalError,
  }) {
    return LoginState(
      status: status ?? this.status,
      isFirstSubmit: isFirstSubmit ?? this.isFirstSubmit,
      taxIdOrIdError: taxIdOrIdError ?? this.taxIdOrIdError,
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      generalError: generalError ?? this.generalError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isFirstSubmit,
        taxIdOrIdError,
        usernameError,
        passwordError,
        generalError,
      ];
}
