import 'package:equatable/equatable.dart';

import '../entity/traveler_entity.dart';

class Traveler extends Equatable {
  final String name;
  final bool sendPushNotifications;

  const Traveler(this.name, this.sendPushNotifications);

  factory Traveler.fromEntity(TravelerEntity entity) {
    return Traveler(entity.username, entity.sendPushNotifications);
  }

  @override
  List<Object?> get props => <Object?>[name, sendPushNotifications];
}
