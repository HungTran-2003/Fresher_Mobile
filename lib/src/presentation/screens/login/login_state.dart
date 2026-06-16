part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus status;
  final bool isFirstSubmit;
  final String taxIdOrId;
  final String username;
  final String password;


  const LoginState({
    this.status = LoadStatus.initial,
    this.isFirstSubmit = false,
    this.taxIdOrId = '',
    this.username = '',
    this.password = '',
  });

  LoginState copyWith({
    LoadStatus? status,
    bool? isFirstSubmit,
    String? taxIdOrId,
    String? username,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      isFirstSubmit: isFirstSubmit ?? this.isFirstSubmit,
      taxIdOrId: taxIdOrId ?? this.taxIdOrId,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isFirstSubmit,
        taxIdOrId,
        username,
        password,
      ];
}
