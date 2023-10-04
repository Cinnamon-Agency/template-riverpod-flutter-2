import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infra/auth/service/auth_service.dart';
import 'login_state.dart';

final loginControllerProvider = NotifierProvider.autoDispose<LoginController, LoginState>(
  () => LoginController(),
);

class LoginController extends AutoDisposeNotifier<LoginState> {
  AuthService get _authService => ref.read(authServiceProvider);

  @override
  LoginState build() {
    return const LoginState();
  }

  void validateFields(bool valid) {
    state = state.copyWith(allFieldsValid: valid);
  }

  void triggerLoginWithEmail({required String email, required String password}) {
    _authService.logIn(email: email, password: password);
  }
}
