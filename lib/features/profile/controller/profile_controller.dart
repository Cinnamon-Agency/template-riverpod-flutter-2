import 'package:cinnamon_riverpod_2/features/profile/controller/profile_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateNotifierProvider<ProfileController, ProfileState>
    profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileState>(
  (AutoDisposeStateNotifierProviderRef<ProfileController, ProfileState> ref) =>
      ProfileController(ref.read(authServiceProvider)),
);

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController(this.firebaseAuthService) : super(const ProfileState());

  FirebaseAuthService firebaseAuthService;

  Future<bool> logOut() async {
    state = const ProfileState(loading: true);

    await firebaseAuthService.logout();

    state = const ProfileState(loading: false);
    return firebaseAuthService.auth.currentUser == null;
  }
}
