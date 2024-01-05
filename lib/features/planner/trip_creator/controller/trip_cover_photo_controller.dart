import 'dart:async';
import 'dart:io';

import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_cover_photo_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final coverPhotoProvider = AutoDisposeAsyncNotifierProvider<CoverPhotoController, TripCoverPhotoState>(
  () => CoverPhotoController(),
);

class CoverPhotoController extends AutoDisposeAsyncNotifier<TripCoverPhotoState> {

  // Open gallery so user can choose trip cover photo
  Future<void> pickImage() async {
    CroppedFile? croppedImage;
    File? file;
    String? imagePath;

// check if permission to enter photo gallery is granted (for iOS), set to TRUE by default)
    var status = true;
    if (Platform.isIOS) {
      status = await Permission.photos.request().isGranted;
    }
    if (status) {
      // If cancel while cropping, open gallery
      while (croppedImage == null) {
        final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
        // If image is chosen, open cropping
        if (pickedImage != null) {
          croppedImage = await ImageCropper().cropImage(
            sourcePath: pickedImage.path,
          );
          // If image is cropped, save it
          if (croppedImage != null) {
            file = File(croppedImage.path);
            imagePath = croppedImage.path;
            state = AsyncData(TripCoverPhotoState(coverPhotoFile: file, imagePath: imagePath));
          }
        } else {
          // no image is picked, return from gallery
          return;
        }
      }
      state = AsyncData(state.requireValue);
    } else {
      // show dialog with message for user to change permission for gallery
      state = AsyncError('Please, grant gallery permission in the device Settings', StackTrace.current);
    }
    return;
  }

  @override
  FutureOr<TripCoverPhotoState> build() => const TripCoverPhotoState(
        coverPhotoFile: null,
        imagePath: null,
      );
}
