import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infra/auth/service/auth_service.dart';
import 'signup_state.dart';

final signupControllerProvider = NotifierProvider.autoDispose<SignupController, SignupState>(
  () => SignupController(),
);

class SignupController extends AutoDisposeNotifier<SignupState> {
  AuthService get _authService => ref.read(authServiceProvider);

  @override
  SignupState build() {
    return SignupState();
  }

  void validateFields(bool valid) {
    state = state.copyWith(allFieldsValid: valid);
  }

  void triggerSignupWithEmail({required String email, required String password}) {
    _authService.createUser(email: email, password: password);
  }
}
