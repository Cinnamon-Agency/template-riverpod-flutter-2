import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/details_sliver_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/map_view.dart';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/widgets/trip_info.dart';
import 'package:cinnamon_riverpod_2/features/shared/adaptive_progress_indicator.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TripDetailsPage extends ConsumerWidget {
  final String tripItineraryId;

  const TripDetailsPage({
    super.key,
    required this.tripItineraryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(tripDetailsControllerProvider(tripItineraryId).notifier);
    final AsyncValue<TripDetailsState> state = ref.watch(tripDetailsControllerProvider(tripItineraryId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: state.when(
          loading: () => const Center(
            child: AdaptiveProgressIndicator(),
          ),
          error: (e, _) => Center(
            child: Text(e.toString()),
          ),
          data: (state) => Stack(
            children: [
              CustomScrollView(
                slivers: [
                  DetailsSliverAppBar(
                    title: state.tripItinerary.name,
                    imageUrl: state.tripItinerary.imageUrl!,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                      child: TripInfo(
                        startDate: state.tripItinerary.startDate,
                        endDate: state.tripItinerary.endDate,
                        info: state.tripItinerary.description,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 72),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trip locations".toUpperCase(),
                            style: context.theme.textTheme.labelSmall
                                ?.copyWith(color: context.theme.textTheme.labelSmall?.color?.withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (state.tripItinerary.locations.isEmpty)
                            const Center(
                              child: Text("You haven't added any locations to this trip."),
                            )
                          else
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                height: 200,
                                child: Stack(
                                  children: [
                                    MapView(
                                      locations: state.tripItinerary.locations,
                                      isMapEnabled: false,
                                    ).animate().shimmer().fadeIn(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              RoundedIconButton(
                                                icon: CupertinoIcons.arrow_right,
                                                size: 40,
                                                iconColor: Colors.white,
                                                onPressed: () {
                                                  GoRouter.of(context)
                                                      .push(RoutePaths.tripMap, extra: state.tripItinerary.id);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (!state.tripItinerary.hasEnded)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 48,
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: PrimaryButton(
                      text: state.tripItinerary.locations.isEmpty
                          ? 'Add locations before starting your trip'
                          : state.tripItinerary.isOngoing
                              ? 'End trip'
                              : 'Start trip',
                      isDisabled: state.tripItinerary.locations.isEmpty,
                      onPressed: () async {
                        await controller.startOrEndTrip();
                        GoRouter.of(context).push(RoutePaths.tripMap, extra: state.tripItinerary.id);
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
