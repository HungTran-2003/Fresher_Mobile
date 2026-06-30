import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_navigator.dart';
import 'main_state.dart';
class MainCubit extends Cubit<MainState> {
  final MainNavigator navigator;
  MainCubit({
    required this.navigator,
  }) : super(const MainState());
  /// Changes the active sub-screen index.
  void changePage(int index) {
    emit(state.copyWith(activeIndex: index));
  }
}