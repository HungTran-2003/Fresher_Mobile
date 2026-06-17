part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus status;

  const HomeState({
    this.status = LoadStatus.initial,
  });

  HomeState copyWith({
    LoadStatus? status,
    String? username,
    String? fullName,
    bool? useBiometrics,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
