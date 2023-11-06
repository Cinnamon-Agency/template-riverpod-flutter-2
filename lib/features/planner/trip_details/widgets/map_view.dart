import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/map_marker.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

/// Custom map view with tile and marker layer.
///
/// Marker layer displays markers from [locations].
/// Map interactivity can be disabled by setting [isMapEnabled] to `false`.
///
/// [selectedMarkerId] is the ID of the marker/location that is selected and should be highlighted.
/// Pass the [onSelectMarker] callback to control what happens when tapping a marker.
class MapView extends StatelessWidget {
  final MapController? mapController;
  final List<TripLocation> locations;
  final bool isMapEnabled;
  final String? selectedMarkerId;
  final Function(String selectedId)? onSelectMarker;

  const MapView({
    super.key,
    this.mapController,
    this.locations = const <TripLocation>[],
    this.isMapEnabled = true,
    this.selectedMarkerId,
    this.onSelectMarker,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        boundsOptions: const FitBoundsOptions(
          padding: EdgeInsets.all(32),
        ),
        bounds: locations.isNotEmpty ? LatLngBounds.fromPoints(locations.map((e) => e.location).toList()) : null,
        interactiveFlags: isMapEnabled ? InteractiveFlag.all : InteractiveFlag.none,
      ),
      children: [
        TileLayer(
          // For this to work, both light and dark style URLs should be provided in the .env file.
          // Styles can be obtained from different providers, such as Mapbox.
          // In case URLs are not set in the .env file, this will use the fallback URL.
          urlTemplate: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? dotenv.env['MAPS_TILE_DARK_URL']
              : dotenv.env['MAPS_TILE_LIGHT_URL'],
          fallbackUrl: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: dotenv.env['MAPS_USER_AGENT_NAME']!,
        ),
        MarkerLayer(
          markers: locations
              .map(
                (location) => Marker(
                  point: location.location,
                  builder: (_) => GestureDetector(
                    onTap: () {
                      if (isMapEnabled && onSelectMarker != null) {
                        onSelectMarker?.call(location.id);
                      }
                    },
                    child: MapMarker(
                      isVisited: location.isVisited,
                      isSelected: selectedMarkerId == location.id,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
