import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/map_view.dart';
import 'package:cinnamon_riverpod_2/features/shared/app_bars/customizable_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

/// Page that shows trip locations from [tripItinerary] on a map.
class TripMapPage extends ConsumerStatefulWidget {
  final TripItinerary tripItinerary;

  const TripMapPage({
    super.key,
    required this.tripItinerary,
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
  void dispose() {
    animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(tripDetailsControllerProvider.notifier);
    final state = ref.watch(tripDetailsControllerProvider);

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
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.65,
              child: MapView(
                mapController: animatedMapController.mapController,
                locations: widget.tripItinerary.locations,
                selectedMarkerId: state.selectedLocationId,
                onSelectMarker: (String locationId) {
                  controller.selectLocation(locationId);
                },
              ),
            ),
            Positioned(
              bottom: 0,
              child: SafeArea(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(color: context.theme.scaffoldBackgroundColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                      itemCount: widget.tripItinerary.locations.length,
                      itemBuilder: (_, index) {
                        final location = widget.tripItinerary.locations[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Material(
                            color: context.theme.scaffoldBackgroundColor,
                            child: ListTile(
                              selected: state.selectedLocationId == location.id,
                              leading: Text((index + 1).toString()),
                              title: Row(
                                children: [
                                  Text(location.name, style: context.theme.textTheme.labelMedium),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '(${location.duration.inMinutes} min)',
                                    style: context.theme.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              trailing: location.isVisited ? const Icon(CupertinoIcons.check_mark_circled) : null,
                              onTap: () {
                                controller.selectLocation(location.id);
                                animatedMapController.animateTo(dest: location.location, zoom: 15);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
