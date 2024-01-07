import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_cover_photo_controller.dart';

class TripCoverPhoto extends StatelessWidget {
  const TripCoverPhoto({
    super.key,
    required this.editState,
    required this.isEditing,
  });

  final bool isEditing;
  final AsyncValue<TripDetailsState>? editState;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final coverPhotoController = ref.read(coverPhotoProvider.notifier);
        final coverPhotoState = ref.watch(coverPhotoProvider);
        return GestureDetector(
          onTap: () => coverPhotoController.pickImage(),
          child: CircleAvatar(
            radius: 75,
            backgroundColor: lightAppColors.neutralsWhite,
            foregroundImage: (coverPhotoState.requireValue.imagePath ?? '').isEmpty
                ? null
                : Image.file(
              coverPhotoState.requireValue.coverPhotoFile!,
              fit: BoxFit.cover,
            ).image,
            child: isEditing && editState!.hasValue
                ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: editState!.value!.tripItinerary.imageUrl ?? '',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            )
                : Icon(
              Icons.camera_alt,
              color: lightAppColors.primary600,
              size: 38,
            ),
          ),
        );
      },
    );
  }
}