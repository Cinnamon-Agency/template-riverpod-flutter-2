import 'package:cinnamon_riverpod_2/infra/planner/data_source/firebase_trip_datasource.dart';
import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository_implementation.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/firebase_traveler_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/service/firebase_auth_service.dart';

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final userId = ref.watch(userIdProvider);
  final tripDataSource = ref.watch(tripDataSourceProvider);
  final travelerDataSource = ref.watch(travelerDataSourceProvider);
  return TripRepositoryImplementation(tripDataSource, travelerDataSource, userId);
});

abstract interface class TripRepository {
  Stream<List<TripItinerary>> getTripItineraries();
}
