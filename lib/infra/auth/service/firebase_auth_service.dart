import 'package:cinnamon_riverpod_2/infra/auth/service/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:cinnamon_riverpod_2/infra/auth/entity/user_entity.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> init() async {}

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Future<void> signInAnon() async {
    try {
      if (auth.currentUser == null) await auth.signInAnonymously();
    } catch (e) {
      throw AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<void> signInWithApple() async => throw UnimplementedError();

  @override
  Future<void> signInWithGoogle() async => throw UnimplementedError();

  @override
  Future<void> signInWithFacebook() async => throw UnimplementedError();

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}

final firebaseUserProvider = StreamProvider<UserEntity>((ref) async* {
  final stream = ref.watch(authServiceProvider).authStateChanges;
  await for (final user in stream) {
    logger.info("User is $user");
    if (user?.uid == null) {
      await ref.read(authServiceProvider).signInAnon();
    } else {
      yield UserEntity(uid: user!.uid, jwt: user.refreshToken!, isAnonymous: user.isAnonymous);
    }
  }
});

final userIdProvider = Provider<String>((ref) {
  return ref.watch(firebaseUserProvider).requireValue.uid;
});
