import 'dart:developer';

import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:cinnamon_riverpod_2/infra/auth/entity/user_entity.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_result_handler.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      final emailProviderCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await _signInWithCredentialOrLinkUser(emailProviderCredential);
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
  Future<void> signInWithGoogle() async {
    try {
      // always show prompt with google accounts
      _googleSignIn.signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      await _signInWithCredentialOrLinkUser(credential);
    } catch (e) {
      throw AuthResultHandler.handleException(e);
    }
  }

  @override
  Future<void> signInWithFacebook() async => throw UnimplementedError();

  @override
  Future<void> logout() async {
    try {
      // Sign out from Google if the user was signed in with Google
      await _googleSignIn.signOut();

      // Sign out from Firebase
      await auth.signOut();
    } catch (e) {
      // Even if Google sign out fails, we still want to sign out from Firebase
      logger.warning('Failed to sign out from Google: $e');
      await auth.signOut();
    }
  }

  /// Signs in the user with a given [credential].
  ///
  /// In case the user is already logged in (namely, after signing in anonymously),
  /// links the anonymous account with the `credential`
  /// and converts the anonymous account into a permanent one.
  /// If google credentials are already in use, then sign in with those credentials to existing google account.
  /// Otherwise, creates a new account.
  Future<UserCredential?>? _signInWithCredentialOrLinkUser(
      AuthCredential credential) async {
    if (auth.currentUser != null) {
      // User signed in anonymously, link the account
      try {
        final userCredential =
            await auth.currentUser!.linkWithCredential(credential);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'credential-already-in-use':
            return auth.signInWithCredential(credential);
          default:
            {
              log('authentication error: ${e.code}');
              return null;
            }
        }
      }
    } else {
      return auth.signInWithCredential(credential);
    }
  }

  @override
  Future<void> deleteAccount() async => auth.currentUser != null
      ? await auth.currentUser?.delete()
      : throw Exception('User does not exist.');
}

final firebaseUserProvider = StreamProvider<UserEntity>((ref) async* {
  final stream = ref.watch(authServiceProvider).authStateChanges;
  await for (final user in stream) {
    logger.info("User is $user");
    if (user?.uid == null) {
      await ref.read(authServiceProvider).signInAnon();
    } else {
      final userEntity = UserEntity(
          uid: user!.uid,
          jwt: user.refreshToken ?? '',
          isAnonymous: user.isAnonymous);

      yield userEntity;
    }
  }
});

final userIdProvider = Provider<String>((ref) {
  return ref.watch(firebaseUserProvider).requireValue.uid;
});
