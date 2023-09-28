import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/trip_itinerary.dart';
import 'firebase_trip_datasource.dart';

final tripDataSourceProvider = Provider<TripDataSource>((ref) {
  return FirebaseTripDataSource();
});

abstract interface class TripDataSource {
  Stream<List<TripItineraryEntity>> getTripItineraries(String userId);
  Future<void> createTrip(TripItineraryEntity tripItineraryEntity);
}
