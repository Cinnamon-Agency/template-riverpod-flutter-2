import 'package:cinnamon_riverpod_2/helpers/logger.dart';
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
  Future<void> signInAnon();

  /// Creates and signs in a new user,
  /// using the given [email] and [password].
  Future<void> createUser({required String email, required String password});

  /// Logs in the user with [email] and [password].
  Future<void> logIn({required String email, required String password});
}
