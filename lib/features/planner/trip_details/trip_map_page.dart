import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_timer_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/map_view.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/trip_locations_list.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/trip_progress_card.dart';
import 'package:cinnamon_riverpod_2/features/shared/adaptive_progress_indicator.dart';
import 'package:cinnamon_riverpod_2/features/shared/app_bars/customizable_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/extensions/duration_extension.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

/// Map that shows trip locations from trip with ID of [tripItineraryId].
class TripMapPage extends ConsumerStatefulWidget {
  final String tripItineraryId;

  const TripMapPage({
    super.key,
    required this.tripItineraryId,
  });

  @override
  ConsumerState<TripMapPage> createState() => _TripMapPageState();
}

class _TripMapPageState extends ConsumerState<TripMapPage> with TickerProviderStateMixin {
  late AnimatedMapController animatedMapController;

  @override
  void initState() {
    super.initState();
    animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tripDetailsControllerProvider(widget.tripItineraryId).notifier);
    final AsyncValue<TripDetailsState> state = ref.watch(tripDetailsControllerProvider(widget.tripItineraryId));

    return Scaffold(
      appBar: CustomizableAppBar(
        isTransparent: true,
        leadingAction: RoundedIconButton.back(
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: state.when(
          loading: () => const Center(
            child: AdaptiveProgressIndicator(),
          ),
          error: (e, _) => Center(
            child: Text(
              e.toString(),
            ),
          ),
          data: (data) {
            Duration? duration;

            if (data.currentLocation != null) {
              duration =
                  ref.watch(tripTimerControllerProvider((data.tripItinerary.id, data.currentLocation!))).remainingTime;
            }

            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: MapView(
                    mapController: animatedMapController.mapController,
                    locations: data.tripItinerary.locations,
                    selectedMarkerId: data.currentLocation?.id,
                    onSelectMarker: (String locationId) {
                      controller.selectLocation(locationId);
                    },
                    mapBottomPadding: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Column(
                      children: [
                        if (data.tripItinerary.isOngoing && data.currentLocation != null)
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 65,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: context.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TripProgressCard(
                              remainingMinutes: duration != null ? duration.inCeilMinutes : 0,
                              actionButtonText: data.tripItinerary.isOngoing && data.nextLocation != null
                                  ? context.L.moveToNext
                                  : data.nextLocation == null
                                      ? context.L.endTrip
                                      : context.L.startTrip,
                              onTapActionButton: data.tripItinerary.isOngoing
                                  ? () => controller.moveToNextLocation()
                                  : () => controller.startOrEndTrip(),
                              isActionButtonDisabled: data.tripItinerary.hasEnded,
                            ),
                          ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.35,
                          width: MediaQuery.sizeOf(context).width,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TripLocationsList(
                              tripLocations: data.tripItinerary.locations,
                              selectedLocation: data.currentLocation,
                              onTapLocation: (TripLocation location) {
                                controller.selectLocation(location.id);
                                animatedMapController.animateTo(dest: location.location, zoom: 15);
                              },
                              isEnabled: !data.tripItinerary.isOngoing,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    animatedMapController.dispose();
    super.dispose();
  }
}
