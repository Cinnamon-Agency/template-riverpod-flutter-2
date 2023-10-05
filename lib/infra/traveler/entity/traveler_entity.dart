import 'package:cloud_firestore/cloud_firestore.dart';

class TravelerEntity {
  final String id;
  final String username;
  final String email;

  const TravelerEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  factory TravelerEntity.fromDoc(DocumentSnapshot doc) {
    print(doc);
    return TravelerEntity(
      id: doc.id,
      username: doc["username"],
      email: doc["email"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
