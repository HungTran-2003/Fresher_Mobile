part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final String username;
  final String fullName;

  const HomeState({
    this.status = LoadStatus.initial,
    this.username = '',
    this.fullName = '',
  });

  HomeState copyWith({
    LoadStatus? status,
    String? username,
    String? fullName,
  }) {
    return HomeState(
      status: status ?? this.status,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [status, username, fullName];
}
