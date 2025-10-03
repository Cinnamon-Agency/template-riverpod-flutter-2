import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/onboarding/controllers/onboarding_state.dart';
import 'package:cinnamon_riverpod_2/helpers/snackbar_helper.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_exceptions.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:permission_handler/permission_handler.dart';

final onboardingControllerProvider =
    StateNotifierProvider.autoDispose<OnboardingController, OnboardingState>(
  (ref) => OnboardingController(),
);

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(const OnboardingState());

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

  void onPressStart(BuildContext context) =>
      GoRouter.of(context).go(RoutePaths.start);

  void onPressSignUp(BuildContext context) =>
      GoRouter.of(context).push(RoutePaths.signup);

  Future<void> onPressSignUpWithGoogle(
      BuildContext context, WidgetRef ref) async {
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signInWithGoogle();
      await _ensureTravelerProfileExists(ref);
      if (context.mounted) {
        GoRouter.of(context).pushAndRemoveUntil(RoutePaths.home);
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        SnackbarHelper.showTFSnackbar(context, e.localizedMessage(context));
      }
    }
  }

  void onPressLogin(BuildContext context) =>
      GoRouter.of(context).push(RoutePaths.login);

  /// Ensures that a traveler profile exists for the current user.
  /// If not, creates one using Google account information.
  Future<void> _ensureTravelerProfileExists(WidgetRef ref) async {
    try {
      final travelerRepo = ref.read(travelerRepositoryProvider);
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      // Try to get existing profile
      try {
        final traveler = await travelerRepo.getProfileData();
        log('---------------traveler exists: $traveler');
        // Profile exists, nothing to do
        return;
      } catch (e) {
        // Profile doesn't exist, create one
        if (e is TravelerNotFoundException) {
          // Request notification permission
          final PermissionStatus status =
              await Permission.notification.request();
          final bool notificationsPermissionGranted =
              status.isGranted || status.isProvisional;

          log('-------------- Creating profile using Google account info');
          // Create profile using Google account info
          try {
            final newTraveler = await travelerRepo.createProfile(
              username:
                  user.displayName ?? user.email?.split('@').first ?? 'User',
              email: user.email ?? '',
              sendPushNotifications: notificationsPermissionGranted,
            );
            log('------------------ Traveler created: $newTraveler');
          } catch (e) {
            log('-----------------Error creating profile: ${e.toString()}');
            rethrow;
          }
        } else {
          rethrow;
        }
      }
    } catch (e) {
      // If profile creation fails, we'll let the user handle it later
      // The app will show appropriate error when trying to access profile
      print('Failed to create traveler profile: $e');
    }
  }
}
