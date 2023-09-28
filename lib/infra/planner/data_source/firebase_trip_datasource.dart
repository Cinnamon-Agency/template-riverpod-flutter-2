import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class FirebaseTripDataSource implements TripDataSource {
  final collection = FirebaseFirestore.instance.collection('trips');

  @override
  Stream<List<TripItineraryEntity>> getTripItineraries(String userId) {
    return collection
        .where('ownerIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => TripItineraryEntity.fromDoc(doc)).toList());
  }

  @override
  Future<void> createTrip(TripItineraryEntity tripItineraryEntity) {
    return collection.doc().set(tripItineraryEntity.toMap());
  }
}
