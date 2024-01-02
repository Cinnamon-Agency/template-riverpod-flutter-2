import 'package:cinnamon_riverpod_2/infra/planner/model/osm_location.dart';

class OsmLocationEntity {
  final int osmId;
  final String name;
  final String displayName;
  final String lat;
  final String lng;
  const OsmLocationEntity({
    required this.osmId,
    required this.name,
    required this.displayName,
    required this.lat,
    required this.lng,
  });

  factory OsmLocationEntity.fromMap(map) {
    return OsmLocationEntity(
      osmId: map["osm_id"],
      name: map["name"],
      displayName: map["display_name"],
      lat: map["lat"],
      lng: map["lon"],
     );
  }

   factory OsmLocationEntity.fromOsmLocation(OsmLocation location) {
    return OsmLocationEntity(
      osmId: location.osmId,
      name: location.name,
      displayName: location.displayName,
      lat: location.lat,
      lng: location.lng,
    );
  }


}
