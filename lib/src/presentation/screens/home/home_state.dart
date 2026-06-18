part of 'home_cubit.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final int activeTab;

  const HomeState({
    this.status = LoadStatus.initial,
    this.activeTab = 0,
  });

  HomeState copyWith({
    LoadStatus? status,
    int? activeTab,
  }) {
    return HomeState(
      status: status ?? this.status,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [status, activeTab];
}
