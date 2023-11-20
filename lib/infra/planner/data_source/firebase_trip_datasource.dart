import 'dart:developer';

import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class FirebaseTripDataSource implements TripDataSource {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('trips');

  @override
  Stream<List<TripItineraryEntity>> getTripItineraries(String userId) {
    return collection.where('ownerIds', arrayContains: userId).snapshots().map(
            (QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => TripItineraryEntity.fromDoc(doc))
            .toList());
  }

  @override
  Stream<TripItineraryEntity> getSingleTripItinerary(String itineraryId) {
    return collection
        .doc(itineraryId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> doc) => TripItineraryEntity.fromDoc(doc));
  }

  @override
  Future<void> createTrip(TripItineraryEntity tripItineraryEntity) async {
    Map<String, dynamic> trip = tripItineraryEntity.toMap();
    trip.remove('id');
    try {
      await collection.doc().set(trip);
    } catch (e) {
      log('Failed to add trip: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTripItineraryData(TripItineraryEntity tripItineraryEntity) async {
    try {
      DocumentReference<Map<String, dynamic>> doc = collection.doc(tripItineraryEntity.id);
      await doc.update(tripItineraryEntity.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeUserTrips(String userId) async {
    QuerySnapshot<Map<String, dynamic>> snap = await collection.where('ownerIds', arrayContains: userId).get();

    for (DocumentSnapshot<Map<String, dynamic>> doc in snap.docs) {
      doc.reference.delete();
    }
  }
}
