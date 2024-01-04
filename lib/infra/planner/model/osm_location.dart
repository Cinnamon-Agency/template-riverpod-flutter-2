import 'package:equatable/equatable.dart';

import 'package:cinnamon_riverpod_2/infra/planner/entity/osm_location.dart';

class OsmLocation extends Equatable {
  final int osmId;
  final String name;
  final String displayName;
  final String lat;
  final String lng;
  const OsmLocation({
    required this.osmId,
    required this.name,
    required this.displayName,
    required this.lat,
    required this.lng,
  });

  factory OsmLocation.fromEntity(
      OsmLocationEntity entity,
      ) {
    return OsmLocation(
      osmId: entity.osmId,
      name: entity.name,
      displayName: entity.displayName,
      lat: entity.lat,
      lng: entity.lng,
    );
  }

  @override
  List<Object?> get props => [osmId, name, displayName, lat, lng];

  OsmLocation copyWith({
    int? osmId,
    String? name,
    String? displayName,
    String? lat,
    String? lng,
  }) {
    return OsmLocation(
      osmId: osmId ?? this.osmId,
      name: name ?? this.name,
      displayName: name ?? this.displayName,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
