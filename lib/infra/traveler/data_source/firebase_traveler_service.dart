import 'dart:developer';

import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../repository/traveler_exceptions.dart';

class FirebaseTravelerDataSource implements TravelerDataSource {
  final collection = FirebaseFirestore.instance.collection('travelers');

  @override
  Future<TravelerEntity> getTraveler(String id) {
    return collection.doc(id).get().then((value) {
      if (value.exists) {
        return TravelerEntity.fromDoc(value);
      } else {
        throw TravelerNotFoundException();
      }
    });
  }

  @override
  Future<TravelerEntity> createTraveler(String userId, String username, String email) async {
    final existing = await collection.doc(userId).get();
    if (existing.exists) {
      throw TravelerExistsException();
    }
    final traveler = TravelerEntity(id: userId, username: username, email: email);
    await collection.doc(userId).set(traveler.toMap());
    return traveler;
  }

  @override
  Future<void> checkUsernameAvailable(String username) {
    return collection.where('username', isEqualTo: username).get().then((value) {
      if (value.docs.isNotEmpty) {
        throw UsernameTakenException();
      }
    });
  }
}
