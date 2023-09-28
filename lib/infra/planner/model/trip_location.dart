import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class TripLocation extends Equatable {
  final String id;
  final String name;
  final Duration duration;
  final bool isVisited;
  final LatLng location;
  const TripLocation({
    required this.id,
    required this.name,
    required this.duration,
    required this.location,
    required this.isVisited,
  });

  factory TripLocation.fromEntity(
    TripLocationEntity entity,
  ) {
    return TripLocation(
      isVisited: entity.isVisited,
      location: entity.location,
      id: entity.id,
      name: entity.name,
      duration: entity.duration,
    );
  }

  @override
  List<Object?> get props => [id, name, duration];
}
