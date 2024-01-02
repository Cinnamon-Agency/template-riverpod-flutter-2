import 'package:cinnamon_riverpod_2/infra/planner/model/osm_location.dart';
import 'package:equatable/equatable.dart';

class OsmSearchLocationsState extends Equatable {
  final List<OsmLocation> osmSearchLocations;

  const OsmSearchLocationsState({
    required this.osmSearchLocations,
  });

  OsmSearchLocationsState copyWith({
    List<OsmLocation>? osmSearchLocations,
  }) {
    return OsmSearchLocationsState(
      osmSearchLocations: osmSearchLocations ?? this.osmSearchLocations,
   );
  }

  @override
  List<Object?> get props => <Object?>[osmSearchLocations];
}
