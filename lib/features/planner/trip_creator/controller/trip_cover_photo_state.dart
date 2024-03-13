import 'dart:io';

import 'package:equatable/equatable.dart';

class TripCoverPhotoState extends Equatable {
  final File? coverPhotoFile;
  final String? imagePath;

  const TripCoverPhotoState({
     this.coverPhotoFile,
     this.imagePath,
  });

  TripCoverPhotoState copyWith({
    File? coverPhotoFile,
    String? imagePath,
  }) {
    return TripCoverPhotoState(
      coverPhotoFile: coverPhotoFile ?? this.coverPhotoFile,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => <Object?>[coverPhotoFile, imagePath];
}
