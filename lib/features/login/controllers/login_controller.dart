import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/features/login/controllers/login_state.dart';

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

  Future triggerLoginWithEmail({required String email, required String password}) {
    state = state.copyWith(isLoading: true);
    return _authService
        .logIn(email: email, password: password)
        .whenComplete(() => state = state.copyWith(isLoading: false));
  }
}
