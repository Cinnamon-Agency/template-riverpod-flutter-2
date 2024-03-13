import 'package:cinnamon_riverpod_2/features/signup/controllers/signup_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final signupControllerProvider =
    NotifierProvider.autoDispose<SignupController, SignupState>(
  () => SignupController(),
);

class SignupController extends AutoDisposeNotifier<SignupState> {
  AuthService get _authService => ref.read(authServiceProvider);

  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

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

      PermissionStatus status = await Permission.notification.request();

      bool notificationsPermissionGranted =
          status.isGranted || status.isProvisional;

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
