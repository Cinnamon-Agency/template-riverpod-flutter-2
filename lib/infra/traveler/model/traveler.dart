import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:equatable/equatable.dart';

class Traveler extends Equatable {
  final String id;
  final String username;
  final String email;
  final bool sendPushNotifications;

  const Traveler({
    required this.id,
    required this.username,
    required this.email,
    this.sendPushNotifications = true,
  });

  factory Traveler.fromEntity(TravelerEntity entity) => Traveler(
        id: entity.id,
        username: entity.username,
        email: entity.email,
        sendPushNotifications: entity.sendPushNotifications,
      );

  @override
  List<Object?> get props =>
      <Object?>[id, username, email, sendPushNotifications];
}
