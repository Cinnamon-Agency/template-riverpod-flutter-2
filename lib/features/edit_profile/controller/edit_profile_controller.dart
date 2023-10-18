import 'package:cinnamon_riverpod_2/features/edit_profile/controller/edit_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeNotifierProvider<EditProfileController, EditProfileState>
    editProfileControllerProvider =
    NotifierProvider.autoDispose<EditProfileController, EditProfileState>(
  () => EditProfileController(),
);

class EditProfileController extends AutoDisposeNotifier<EditProfileState> {
  @override
  EditProfileState build() {
    return const EditProfileState();
  }
}
