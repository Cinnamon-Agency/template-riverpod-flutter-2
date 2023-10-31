import 'package:cinnamon_riverpod_2/features/edit_profile/view/edit_profile_page.dart';
import 'package:cinnamon_riverpod_2/features/home/view/home_page.dart';
import 'package:cinnamon_riverpod_2/features/login/view/login_page.dart';
import 'package:cinnamon_riverpod_2/features/onboarding/view/onboarding_page.dart';
import 'package:cinnamon_riverpod_2/features/onboarding/view/start_page.dart';
import 'package:cinnamon_riverpod_2/features/settings/view/settings_page.dart';
import 'package:cinnamon_riverpod_2/features/signup/view/signup_page.dart';
import 'package:cinnamon_riverpod_2/features/splash/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/planner/planner_creator/planner_creator_page.dart';

class RoutePaths {
  static const String splash = '/';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String start = '/start';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String editProfile = '/edit_profile';
  static const String settings = '/settings';
  static const String plannerCreator = '/plannerCreator';
}

final GoRouter router = GoRouter(
  initialLocation: RoutePaths.splash,
  observers: [SimpleNavigationObserver()],
  routes: <RouteBase>[
    GoRoute(
      path: RoutePaths.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingPage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.start,
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.signup,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupPage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.editProfile,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfilePage();
      },
      routes: const <RouteBase>[],
    ),
    GoRoute(
      path: RoutePaths.settings,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      },
      routes: const <RouteBase>[],
    ),

    GoRoute(
      path: RoutePaths.plannerCreator,
      builder: (BuildContext context, GoRouterState state) {
        return const PlannerCreatorPage();
      },
      routes: const <RouteBase>[],
    ),
  ],
);

extension GoRouterEXT on GoRouter {
  void pushAndRemoveUntil(String path, [Object? data]) {
    while (canPop()) {
      pop();
    }
    pushReplacement(path, extra: data);
  }
}

class SimpleNavigationObserver extends RouteObserver {
  static String? currentRoute = RoutePaths.splash;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) currentRoute = route.settings.name;
    super.didPush(route, previousRoute);
  }
}
