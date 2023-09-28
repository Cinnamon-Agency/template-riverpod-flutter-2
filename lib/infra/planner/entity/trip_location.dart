import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class TripLocationEntity {
  final String id;
  final String name;
  final Duration duration;
  final bool isVisited;
  final LatLng location;
  const TripLocationEntity({
    required this.id,
    required this.name,
    required this.duration,
    required this.location,
    required this.isVisited,
  });

  factory TripLocationEntity.fromMap(map) {
    return TripLocationEntity(
      id: map["id"],
      location: LatLng(map["location"].latitude, map["location"].longitude),
      isVisited: map["isVisited"],
      name: map['name'],
      duration: Duration(seconds: map['duration']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "location": GeoPoint(location.latitude, location.longitude),
      'isVisited': isVisited,
      'id': id,
      'name': name,
      'duration': duration.inSeconds,
    };
  }
}
