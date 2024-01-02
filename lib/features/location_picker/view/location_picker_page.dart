import 'dart:async';

import 'package:cinnamon_riverpod_2/features/location_picker/view/zoom_in_out_buttons.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/location_index_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/osm_search_locations_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_creation_controller.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/osm_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class LocationPickerPage extends ConsumerStatefulWidget {
  const LocationPickerPage({required this.onLocationSelected, super.key});

  final Function(OsmLocation) onLocationSelected;

  @override
  ConsumerState<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends ConsumerState<LocationPickerPage> {
  late final TextEditingController _textController;
  late final _mapController;
  final _nameNode = FocusNode();

  // for debouncing api calls to open street map (max 1 call per second)
  final Debounce _debounce = Debounce(const Duration(milliseconds: 500));

  // zoom when searching for new location => 13.
  // zoom when editing previously entered location => 15.
  double currentZoom = 13.0;
  LatLng currentCenter = const LatLng(45.7902023, 15.9706199); // Zagreb
  // LatLng of previously entered location we want to edit
  LatLng? editLocation;

  // showing open street map address results when address search field has text.
  // If editing location, search field will have location name, but we don't want
  // to show address results (nor call the osm api)
  bool isSearchNeeded = true;

  void _zoomInMap() {
    currentZoom = currentZoom + 1;
    _mapController.move(currentCenter, currentZoom);
  }

  void _zoomOutMap() {
    currentZoom = currentZoom - 1;
    _mapController.move(currentCenter, currentZoom);
  }

  void _zoomEditLocation(TripLocation editLocation) {
    currentZoom = 15;
    _mapController.move(editLocation.location, currentZoom);
    // we don't need osm api when setting textController.text:
    isSearchNeeded = false;
    _textController.text = editLocation.name;
    isSearchNeeded = true;
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripLocationState = ref.watch(tripCreationStateProvider);
    final searchLocationsState = ref.watch(osmSearchLocationsStateProvider);
    final searchLocationsController = ref.read(osmSearchLocationsStateProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_nameNode.canRequestFocus) {
        _nameNode.requestFocus();
      }
      final index = ref.watch(indexProvider);
      if (index != null && tripLocationState.requireValue.tripLocations[index].name != 'Select Location') {
        _zoomEditLocation(tripLocationState.requireValue.tripLocations[index]);
        editLocation = tripLocationState.requireValue.tripLocations[index].location;
        // set index to null so textController.text wouldn't change again on new build
        ref.read(indexProvider.notifier).setIndex(null);
      }
    });
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: currentCenter,
          zoom: currentZoom,
          minZoom: 1,
          maxZoom: 15,
          onTap: (position, latLng) async {
            if (searchLocationsState.requireValue.osmSearchLocations.isEmpty) {
              final location = await searchLocationsController.getLocationNameForLatLng(latLng);
              if (location != null) {
                widget.onLocationSelected(location);
                GoRouter.of(context).pop();
              }
            } else {
              searchLocationsController.resetState();
            }
          },
        ),
        mapController: _mapController,
        children: [
          /// MapLayer 1------------------ default
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),

          /// MapLayer 2----------------- set Marker if editing location
          if (editLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: editLocation!,
                  builder: (BuildContext context) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 38,
                  ),
                ),
              ],
            ),

          /// MapLayer 3--------------- zoomIn and zoomOut buttons on map
          Align(
            alignment: Alignment.centerRight,
            child: ZoomInOutButtons(onZoomIn: _zoomInMap, onZoomOut: _zoomOutMap),
          ),

          /// MapLayer 4----------------top bar & address suggestions listView
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ///------------------- back btn
                    RoundedIconButton(
                      icon: CupertinoIcons.left_chevron,
                      color: Colors.white.withOpacity(0.7),
                      iconColor: Colors.black,
                      size: 32,
                      onPressed: () {
                        ref.read(indexProvider.notifier).setIndex(0);
                        GoRouter.of(context).pop();
                      },
                      tooltipMessage: context.localization.back,
                    ),

                    ///------------------- address search field
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'search',
                        focusNode: _nameNode,
                        controller: _textController,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Search Location',
                        ),
                        onChanged: (text) async {
                          if (text != null && isSearchNeeded) {
                            _debounce(() async {
                              await searchLocationsController.getLocationFromSearchField(text);
                            });
                          }
                        },
                        onSubmitted: (text) async {},
                        validator: (value) => null,
                      ),
                    ),
                  ],
                ),

                ///------------------- address suggestions from open street map API
                Padding(
                  padding: const EdgeInsets.only(
                    left: 60.0,
                    top: 5,
                  ),
                  child: searchLocationsState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black26)),
                          child: searchLocationsState.hasError
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${searchLocationsState.error}'),
                                )
                              : searchLocationsState.requireValue.osmSearchLocations.isNotEmpty
                                  ? ListView.separated(
                                      padding: const EdgeInsets.all(15),
                                      shrinkWrap: true,
                                      itemCount: searchLocationsState.requireValue.osmSearchLocations.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () {
                                            searchLocationsController.resetState();
                                            widget.onLocationSelected(
                                                searchLocationsState.requireValue.osmSearchLocations[index]);
                                            GoRouter.of(context).pop();
                                          },
                                          child: Text(
                                            searchLocationsState.requireValue.osmSearchLocations[index].displayName,
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    )
                                  : const SizedBox(),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Debounce {
  Duration delay;
  Timer? _timer;

  Debounce(this.delay);

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}
