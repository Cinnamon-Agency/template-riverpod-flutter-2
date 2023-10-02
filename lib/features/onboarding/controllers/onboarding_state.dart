import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  /// Tracks the active page of the PageView
  final int currentPage;

  /// Tracks whether the user has scrolled through all onboarding steps
  final bool onboardingFinished;

  const OnboardingState({
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

  @override
  List<Object?> get props => [
        currentPage,
        onboardingFinished,
      ];
}
