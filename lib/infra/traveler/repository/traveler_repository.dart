import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/service/firebase_auth_service.dart';
import '../data_source/traveler_data_source.dart';

final travelerRepositoryProvider = Provider<TravelerRepository>((ref) {
  final travelerDataSource = ref.watch(travelerDataSourceProvider);
  final userId = ref.watch(userIdProvider);
  return TravelerRepositoryImpl(travelerDataSource, userId);
});

abstract interface class TravelerRepository {
  Future<Traveler> myProfile();

  Future<void> checkUsernameAvailable(String username);

  Future<Traveler> createProfile({required String username, required String email});
}
