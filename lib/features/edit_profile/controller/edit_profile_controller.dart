import 'package:cinnamon_riverpod_2/features/edit_profile/controller/edit_profile_state.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editProfileControllerProvider =
    AutoDisposeAsyncNotifierProvider<EditProfileController, EditProfileState>(
  () => EditProfileController(),
);

class EditProfileController extends AutoDisposeAsyncNotifier<EditProfileState> {
  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

  @override
  EditProfileState build() {
    return EditProfileState(
        username: ref.read(profileDataProvider).value?.name ?? '');
  }

  void onUsernameTextChange(String value) {
    state = AsyncData(EditProfileState(
      username: value,
      isUsernameValid:
          (ref.read(profileDataProvider).value?.name ?? '') != value,
    ));
  }

  void onSubmit() async {
    state = const AsyncLoading();
    await _travelerRepo.updateProfileData(<String, dynamic>{
      'username': state.requireValue.username,
    });
    state = AsyncData(EditProfileState(
      username: ref.refresh(profileDataProvider).requireValue.name,
      isUsernameValid: false,
    ));
  }
}
