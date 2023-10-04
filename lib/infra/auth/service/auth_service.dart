import 'package:cinnamon_riverpod_2/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_auth_service.dart';

final authServiceProvider = Provider((ref) => FirebaseAuthService());

abstract interface class AuthService {
  /// Initializes the authentication service.
  Future<void> init();

  Stream<fb.User?> get authStateChanges;

  /// Signs the user anonymously,
  /// without needing to create an account
  /// using email and password.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> signInAnon();

  /// Creates and signs in a new user,
  /// using the given [email] and [password].
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> createUser({required String email, required String password});

  /// Logs in the user with [email] and [password].
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> logIn({required String email, required String password});

  /// Signs in the user using Apple auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> signInWithApple();

  /// Signs in the user using Google auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> signInWithGoogle();

  /// Signs in the user using Facebook auth flow.
  ///
  /// Returns `AuthResultStatus`, which can be in a success state
  /// or one of error states.
  Future<AuthResultStatus> signInWithFacebook();

  /// Logs out the currently active user.
  Future<void> logout();
}
