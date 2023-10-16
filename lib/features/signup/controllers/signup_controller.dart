import 'package:cinnamon_riverpod_2/infra/firebase_notifications/firebase_notifications_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infra/auth/service/auth_service.dart';
import 'signup_state.dart';

final signupControllerProvider = NotifierProvider.autoDispose<SignupController, SignupState>(
      () => SignupController(),
);

class SignupController extends AutoDisposeNotifier<SignupState> {
  AuthService get _authService => ref.read(authServiceProvider);

  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

  FirebaseNotificationsService get _fns =>
      ref.read(firebaseNotificationsService);

  @override
  SignupState build() {
    return const SignupState();
  }

  void validateFields(bool valid) {
    state = state.copyWith(allFieldsValid: valid);
  }

  Future<void> triggerSignupWithEmail(
      {required String email,
      required String password,
      required String username}) async {
    state = state.copyWith(loading: true);
    try {
      await _travelerRepo.checkUsernameAvailable(username);

      await _authService.createUser(email: email, password: password);

      bool notificationsPermissionGranted = await _fns.askForPermissions();

      await _travelerRepo.createProfile(
          username: username,
          email: email,
          sendPushNotifications: notificationsPermissionGranted);
    } catch (e) {
      rethrow;
    } finally {
      state = state.copyWith(loading: false);
    }
  }
}
