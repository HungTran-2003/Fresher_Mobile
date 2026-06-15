enum OnboardingStatus { initial, loading, success, failure }

class OnboardingState {
  final OnboardingStatus status;
  final int currentPageIndex;
  final String? errorMessage;

  const OnboardingState({
    required this.status,
    this.currentPageIndex = 0,
    this.errorMessage,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      status: OnboardingStatus.initial,
      currentPageIndex: 0,
    );
  }

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentPageIndex,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
