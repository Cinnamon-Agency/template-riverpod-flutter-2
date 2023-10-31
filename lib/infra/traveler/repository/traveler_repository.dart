import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<TravelerRepository> travelerRepositoryProvider =
    Provider<TravelerRepository>((ProviderRef<TravelerRepository> ref) {
  final TravelerDataSource travelerDataSource =
      ref.watch(travelerDataSourceProvider);
  final String userId = ref.watch(userIdProvider);
  return TravelerRepositoryImpl(travelerDataSource, userId);
});

final AutoDisposeFutureProvider<Traveler> profileDataProvider =
    AutoDisposeFutureProvider<Traveler>(
        (AutoDisposeFutureProviderRef<Traveler> ref) =>
            ref.watch(travelerRepositoryProvider).getProfileData());

abstract interface class TravelerRepository {
  Future<Traveler> getProfileData();

  Future<void> updateProfileData(Map<String, dynamic> data);

  Future<void> checkUsernameAvailable(String username);

  Future<Traveler> createProfile({
    required String username,
    required String email,
    bool sendPushNotifications,
  });

  Future<void> deleteProfile();
}
