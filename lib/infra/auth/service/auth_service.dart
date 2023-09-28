import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_auth_service.dart';

final authServiceProvider = Provider((ref) => FirebaseAuthService());

abstract interface class AuthService {
  Future<void> init();
  Future<void> signInAnon();
  Stream<fb.User?> get authStateChanges;
}
