import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/map_view.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/trip_locations_list.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/trip_progress_card.dart';
import 'package:cinnamon_riverpod_2/features/shared/adaptive_progress_indicator.dart';
import 'package:cinnamon_riverpod_2/features/shared/app_bars/customizable_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
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
          data: (state) => Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: MapView(
                  mapController: animatedMapController.mapController,
                  locations: state.tripItinerary.locations,
                  selectedMarkerId: state.currentLocation?.id,
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
                      if (state.tripItinerary.isOngoing && state.currentLocation != null)
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TripProgressCard(
                            remainingMinutes: state.currentLocation!.duration.inMinutes,
                            actionButtonText: state.tripItinerary.isOngoing && state.nextLocation != null
                                ? "Move to next"
                                : state.nextLocation == null
                                    ? "End trip"
                                    : "Start trip",
                            onTapActionButton: state.tripItinerary.isOngoing
                                ? () => controller.moveToNextLocation()
                                : () => controller.startOrEndTrip(),
                            isActionButtonDisabled: state.tripItinerary.hasEnded,
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
                            tripLocations: state.tripItinerary.locations,
                            selectedLocation: state.currentLocation,
                            onTapLocation: (TripLocation location) {
                              controller.selectLocation(location.id);
                              animatedMapController.animateTo(dest: location.location, zoom: 15);
                            },
                            isEnabled: !state.tripItinerary.isOngoing,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
