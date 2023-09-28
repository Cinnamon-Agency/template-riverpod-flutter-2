import 'package:cloud_firestore/cloud_firestore.dart';

class TravelerEntity {
  final String id;
  final String name;

  const TravelerEntity({
    required this.id,
    required this.name,
  });

  factory TravelerEntity.fromDoc(DocumentSnapshot doc) {
    return TravelerEntity(
      id: doc.id,
      name: doc["name"],
    );
  }
}
