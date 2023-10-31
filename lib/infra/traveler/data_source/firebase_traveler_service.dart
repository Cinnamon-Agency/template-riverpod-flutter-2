import 'dart:developer';

import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTravelerDataSource implements TravelerDataSource {
  FirebaseTravelerDataSource(this.userID);

  final String userID;

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('travelers');

  @override
  Future<TravelerEntity> getTraveler(String id) {
    return collection
        .doc(id)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) {
      if (value.exists) {
        return TravelerEntity.fromDoc(value);
      } else {
        throw TravelerNotFoundException();
      }
    });
  }

  @override
  Future<void> updateProfileData(Map<String, dynamic> data) async {
    try {
      DocumentReference<Map<String, dynamic>> doc = collection.doc(userID);
      await doc.update(data);
    } catch (e) {
      log('Failed to update user data for user_id: $userID.');
      rethrow;
    }
  }

  @override
  Future<TravelerEntity> createTraveler({
    required String userId,
    required String username,
    required String email,
    required bool sendPushNotifications,
  }) async {
    final DocumentSnapshot<Map<String, dynamic>> existing =
        await collection.doc(userId).get();
    if (existing.exists) {
      throw TravelerExistsException();
    }
    final TravelerEntity traveler =
        TravelerEntity(id: userId, username: username, email: email);
    await collection.doc(userId).set(traveler.toMap());
    return traveler;
  }

  @override
  Future<void> checkUsernameAvailable(String username) {
    return collection
        .where('username', isEqualTo: username)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) {
      if (value.docs.isNotEmpty) {
        throw UsernameTakenException();
      }
    });
  }

  @override
  Future<void> deleteTraveler() async{
    try {
      DocumentReference<Map<String, dynamic>> doc = collection.doc(userID);
      await doc.delete();
    } catch (e) {
      log('Failed to delete user $userID.');
      rethrow;
    }
  }
}
