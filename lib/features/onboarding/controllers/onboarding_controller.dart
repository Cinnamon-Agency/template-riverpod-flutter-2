import 'package:cinnamon_riverpod_2/features/onboarding/controllers/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingControllerProvider = StateNotifierProvider.autoDispose<OnboardingController, OnboardingState>(
  (ref) => OnboardingController(),
);

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(OnboardingState());

  final pageController = PageController();

  /// Updates [state.currentPage] to [page].
  /// Additionally, marks onboarding as finished if the user
  /// has reached the final page.
  void updateCurrentPage(int page) {
    final isOnboardingFinished = page == 2;

    state = state.copyWith(
      currentPage: page,
      onboardingFinished: isOnboardingFinished ? true : null,
    );
  }

  /// TODO: Implement onPressStart
  Future<void> onPressStart(BuildContext context) => throw UnimplementedError();
}
