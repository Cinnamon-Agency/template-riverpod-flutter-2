import 'dart:developer';

import 'package:cinnamon_riverpod_2/features/profile/controller/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStateNotifierProvider<ProfileController, ProfileState>
    profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, ProfileState>(
  (AutoDisposeStateNotifierProviderRef<ProfileController, ProfileState> ref) =>
      ProfileController(),
);

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController() : super(const ProfileState());

  Future<bool> logOut() async {
    state = const ProfileState(loading: true);
    log('Logging out');
    // TODO(Josip): Implement log out logic
    await Future<void>.delayed(const Duration(seconds: 3));
    state = const ProfileState(loading: false);
    log('Logged out');
    return true;
  }
}
