import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;

  @override
  Future<void> init() async {}

  @override
  Future<void> signInAnon() async {
    if (auth.currentUser == null) await auth.signInAnonymously();
  }

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

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
