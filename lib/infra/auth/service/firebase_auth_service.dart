import 'package:cinnamon_riverpod_2/constants/enums.dart';
import 'package:cinnamon_riverpod_2/helpers/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> init() async {}

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Future<AuthResultStatus> signInAnon() async {
    try {
      if (auth.currentUser == null) await auth.signInAnonymously();
      return AuthResultStatus.successful;
    } catch (e) {
      return AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<AuthResultStatus> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return AuthResultStatus.successful;
    } catch (e) {
      return AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<AuthResultStatus> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResultStatus.successful;
    } catch (e) {
      return AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<AuthResultStatus> signInWithApple() async => throw UnimplementedError();

  @override
  Future<AuthResultStatus> signInWithGoogle() async => throw UnimplementedError();

  @override
  Future<AuthResultStatus> signInWithFacebook() async => throw UnimplementedError();

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}

final firebaseUserProvider = StreamProvider<User>((ref) async* {
  final stream = ref.watch(authServiceProvider).authStateChanges;
  await for (final user in stream) {
    logger.info("User is $user");
    if (user?.uid == null) {
      await ref.read(authServiceProvider).signInAnon();
    } else {
      yield user!;
    }
  }
});

final userIdProvider = Provider<String>((ref) {
  return ref.watch(firebaseUserProvider).requireValue.uid;
});
