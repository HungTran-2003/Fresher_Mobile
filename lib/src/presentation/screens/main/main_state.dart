import 'package:equatable/equatable.dart';
class MainState extends Equatable {
  final int activeIndex;
  const MainState({
    this.activeIndex = 0,
  });
  MainState copyWith({
    int? activeIndex,
  }) {
    return MainState(
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }
  @override
  List<Object?> get props => [activeIndex];
}
