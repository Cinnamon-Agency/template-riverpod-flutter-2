import 'package:cinnamon_riverpod_2/infra/planner/data_source/firebase_trip_datasource.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<TripDataSource> tripDataSourceProvider =
    Provider<TripDataSource>((ProviderRef<TripDataSource> ref) => FirebaseTripDataSource());

abstract interface class TripDataSource {
  Stream<List<TripItineraryEntity>> getTripItineraries(String userId);

  Stream<TripItineraryEntity> getSingleTripItinerary(String itineraryId);

  Future<void> createTrip(TripItineraryEntity tripItineraryEntity);

  Future<void> updateTripItineraryData(TripItineraryEntity tripItineraryEntity);

  Future<void> removeUserTrips(String userId);
}
