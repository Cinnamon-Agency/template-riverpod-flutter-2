import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository_implementation.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';

final Provider<TripRepository> tripRepositoryProvider = Provider<TripRepository>((ProviderRef<TripRepository> ref) {
  final String userId = ref.watch(userIdProvider);
  final TripDataSource tripDataSource = ref.watch(tripDataSourceProvider);
  final TravelerDataSource travelerDataSource = ref.watch(travelerDataSourceProvider);

  return TripRepositoryImplementation(tripDataSource, travelerDataSource, userId);
});

abstract interface class TripRepository {
  Stream<List<TripItinerary>> getTripItineraries();

  Stream<TripItinerary> getSingleTripItinerary(String itineraryId);

  Future<void> updateTripItineraryData(TripItinerary tripItinerary);

  Future<void> createTripItinerary(TripItineraryEntity tripItinerary);

  Future<void> createMocked();

  Future<void> removeUserTrips();
}
