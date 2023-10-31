import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';

final authServiceProvider = Provider((ref) => FirebaseAuthService());

abstract interface class AuthService {
  /// Initializes the authentication service.
  Future<void> init();

  Stream get authStateChanges;

  /// Signs the user anonymously,
  /// without needing to create an account
  /// using email and password.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> signInAnon();

  /// Creates and signs in a new user,
  /// using the given [email] and [password].
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> createUser({required String email, required String password});

  /// Logs in the user with [email] and [password].
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> logIn({required String email, required String password});

  /// Signs in the user using Apple auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> signInWithApple();

  /// Signs in the user using Google auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> signInWithGoogle();

  /// Signs in the user using Facebook auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<void> signInWithFacebook();

  /// Logs out the currently active user.
  Future<void> logout();

  /// Deletes current user's account.
  Future<void> deleteAccount();
}
