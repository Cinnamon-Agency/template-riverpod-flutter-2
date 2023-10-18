import 'package:cinnamon_riverpod_2/features/edit_profile/controller/edit_profile_state.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeNotifierProvider<EditProfileController, EditProfileState>
    editProfileControllerProvider =
    NotifierProvider.autoDispose<EditProfileController, EditProfileState>(
  () => EditProfileController(),
);

class EditProfileController extends AutoDisposeNotifier<EditProfileState> {
  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

  @override
  EditProfileState build() {
    return EditProfileState(
        username: ref.read(profileDataProvider).value?.name ?? '');
  }

  void onUsernameTextChange(String value) {
    state = EditProfileState(
      username: value,
      isUsernameValid:
          (ref.read(profileDataProvider).value?.name ?? '') != value,
    );
  }

  void onSubmit() async {
    state = state.copyWith(loading: true);
    await _travelerRepo.updateProfileData(<String, dynamic>{
      'username': state.username,
    });
    state = state.copyWith(
        loading: false,
        username: ref.refresh(profileDataProvider).requireValue.name,
        isUsernameValid: false);
  }
}
