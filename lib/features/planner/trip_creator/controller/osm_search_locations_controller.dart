import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/osm_search_locations_state.dart';
import 'package:cinnamon_riverpod_2/infra/http/http_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/osm_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/osm_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final osmSearchLocationsStateProvider =
    AutoDisposeAsyncNotifierProvider<OsmSearchLocationsController, OsmSearchLocationsState>(
  () => OsmSearchLocationsController(),
);

class OsmSearchLocationsController extends AutoDisposeAsyncNotifier<OsmSearchLocationsState> {
  HttpService get _httpService => ref.read(httpServiceProvider);

  void resetState() {
    state = const AsyncData(OsmSearchLocationsState(
      osmSearchLocations: [],
    ));
  }

  /// Get location from search field
  Future<void> getLocationFromSearchField(String query) async {
    List<OsmLocationEntity> osmLocations = [];
    List<OsmLocation> osmLocationsModels = [];
    state = const AsyncLoading();
    try {
      await _httpService.request(SearchLocationFromQueryRequest(query), transformer: (response) {
        final locationsData = response;

        for (var i = 0; i < (locationsData as List<dynamic>).length; i++) {
          osmLocations.add(OsmLocationEntity.fromMap(locationsData[i]));
        }
        osmLocationsModels = osmLocations.map((l) => OsmLocation.fromEntity(l)).toList();
        state = AsyncData(state.requireValue.copyWith(osmSearchLocations: osmLocationsModels));
      });
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Get address name from tapping location on map
  Future<OsmLocation?> getLocationNameForLatLng(LatLng latLng) async {
    OsmLocationEntity? osmLocation;
    OsmLocation? osmLocationModel;
    state = const AsyncLoading();
    try {
      await _httpService.request(SearchLocationFromLatlngRequest(latLng), transformer: (response) {
        osmLocation = OsmLocationEntity.fromMap(response);
        osmLocationModel = OsmLocation.fromEntity(osmLocation!);
        if (osmLocationModel != null) {
          state = AsyncData(state.requireValue.copyWith(osmSearchLocations: [osmLocationModel!]));
        }
      });
    } catch (e, st) {
      state = AsyncError(e, st);
   }
    return osmLocationModel;
  }

  @override
  FutureOr<OsmSearchLocationsState> build() => const OsmSearchLocationsState(
        osmSearchLocations: [],
      );
}

class SearchLocationFromQueryRequest extends BaseHttpRequest {
  final String query;

  SearchLocationFromQueryRequest(this.query)
      : super(
            endpoint: "/search?addressdetails=1&q=$query&format=jsonv2&limit=5",
            url: 'https://nominatim.openstreetmap.org');

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}

class SearchLocationFromLatlngRequest extends BaseHttpRequest {
  final LatLng latLng;

  SearchLocationFromLatlngRequest(this.latLng)
      : super(
            endpoint: "/reverse?format=jsonv2&lat=${latLng.latitude}&lon=${latLng.longitude}",
            url: 'https://nominatim.openstreetmap.org');

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
