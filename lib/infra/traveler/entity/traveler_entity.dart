import 'package:cloud_firestore/cloud_firestore.dart';

class TravelerEntity {
  final String id;
  final String username;
  final String email;
  final bool sendPushNotifications;

  const TravelerEntity({
    required this.id,
    required this.username,
    required this.email,
    this.sendPushNotifications = true,
  });

  factory TravelerEntity.fromDoc(DocumentSnapshot d) {
    final doc = d.data() as Map<String, dynamic>;
    return TravelerEntity(
      id: d.id,
      username: doc["username"],
      email: doc["email"],
      sendPushNotifications: doc["sendPushNotifications"].toString() == "true",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'sendPushNotifications': sendPushNotifications,
    };
  }
}
