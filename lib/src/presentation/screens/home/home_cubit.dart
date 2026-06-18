import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:crud_app/src/domain/models/enum/load_status.dart';
import 'home_navigator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit({
    required this.navigator,
  }) : super(const HomeState());

  Future<void> init() async {}

  /// Changes the active skill tab in the bottom navigation.
  void changeTab(int index) {
    emit(state.copyWith(activeTab: index));
  }
}
