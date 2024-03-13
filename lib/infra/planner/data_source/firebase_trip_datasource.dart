import 'dart:developer';
import 'dart:io';

import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final class FirebaseTripDataSource implements TripDataSource {
  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('trips');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

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
  Future<void> createTrip(TripItineraryEntity tripItineraryEntity, {File? coverPhoto}) async {
    DocumentReference? tripReference;
    Map<String, dynamic> trip = tripItineraryEntity.toMap();
    trip.remove('id');
    try {
      await collection.add(trip).then((tripRef) {
        // set trip id as document field on trip create, instead on first trip update
        updateTripItineraryFields(dataForUpdate: {'id': tripRef.id}, tripId: tripRef.id);
        return tripReference = tripRef;
      });
      if (coverPhoto != null) {
        await uploadTripCoverPhotoToFBStorage(coverPhoto, tripReference!.id);
      }
    } catch (e) {
      log('Failed to add trip: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateTripItineraryData(TripItineraryEntity tripItineraryEntity, {File? coverPhoto}) async {
    try {
      DocumentReference<Map<String, dynamic>> doc = collection.doc(tripItineraryEntity.id);
      await doc.update(tripItineraryEntity.toMap());
      if (coverPhoto != null) {
        await uploadTripCoverPhotoToFBStorage(coverPhoto, tripItineraryEntity.id);
      }
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

 Future<void> uploadTripCoverPhotoToFBStorage(File coverPhoto, String tripId) async {
   try {
     await firebaseStorage.ref('tripImages/$tripId/coverPhoto').putFile(coverPhoto).then((image) async {
       final imageUrl = await image.ref.getDownloadURL();
       final data = {'imageUrl': imageUrl};

       // Update tripCoverUrl to trip doc in Cloud Firestore
       updateTripItineraryFields(dataForUpdate: data, tripId: tripId);
     });
   } catch (e) {
     rethrow;
   }
 }

  Future<void> updateTripItineraryFields({required Map<String, dynamic> dataForUpdate, required String tripId}) async {
    try {
      await collection.doc(tripId).update(dataForUpdate);
    } catch (e) {
      rethrow;
    }
  }

}
