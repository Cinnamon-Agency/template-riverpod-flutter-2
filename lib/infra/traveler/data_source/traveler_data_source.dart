import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_traveler_service.dart';

final travelerDataSourceProvider = Provider<TravelerDataSource>((ref) {
  return FirebaseTravelerDataSource();
});

abstract interface class TravelerDataSource {
  Future<TravelerEntity> getTraveler(String userId);

  Future<TravelerEntity> createTraveler({
    required String userId,
    required String username,
    required String email,
    required bool sendPushNotifications,
  });

  Future<void> checkUsernameAvailable(String username);
}
