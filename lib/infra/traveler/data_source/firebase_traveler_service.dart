import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTravelerDataSource implements TravelerDataSource {
  final collection = FirebaseFirestore.instance.collection('travelers');

  @override
  Future<TravelerEntity> getTraveler(String id) async {
    return collection.doc(id).snapshots().first.then((doc) => TravelerEntity.fromDoc(doc));
  }
}
