import 'package:finance/src/domain/models/enum/onboarding_step.dart';
import 'package:finance/src/domain/repositories/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_navigator.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SettingRepository _settingRepository;
  final OnboardingNavigator navigator;

  OnboardingCubit({
    required SettingRepository settingRepository,
    required this.navigator,
  }) : _settingRepository = settingRepository,
       super(OnboardingState.initial()) {
    _setFirstRun();
  }

  Future<void> _setFirstRun() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _settingRepository.setFirstRun(isFirstRun: true);
    result.fold(
      ifLeft: (error) => emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
      ifRight: (_) => emit(state.copyWith(status: OnboardingStatus.success)),
    );
  }

  void onPageChanged(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }

  void next(PageController pageController) {
    if (state.currentPageIndex < OnboardingStep.values.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigator.toDashboard();
    }
  }
}
