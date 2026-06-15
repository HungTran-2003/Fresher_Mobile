part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final LoadStatus signOutStatus;
  final bool isAuthenticated;

  const AuthState({
    this.signOutStatus = LoadStatus.initial,
    this.isAuthenticated = false,
  });

  @override
  List<Object?> get props => [signOutStatus, isAuthenticated];

  AuthState copyWith({LoadStatus? signOutStatus, bool? isAuthenticated}) {
    return AuthState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
