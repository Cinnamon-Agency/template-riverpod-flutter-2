class OnboardingState {
  /// Tracks the active page of the PageView
  final int currentPage;

  /// Tracks whether the user has scrolled through all onboarding steps
  final bool onboardingFinished;

  OnboardingState({
    this.currentPage = 0,
    this.onboardingFinished = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? onboardingFinished,
  }) =>
      OnboardingState(
        currentPage: currentPage ?? this.currentPage,
        onboardingFinished: onboardingFinished ?? this.onboardingFinished,
      );
}
