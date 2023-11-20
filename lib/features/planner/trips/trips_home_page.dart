import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/no_trips_placeholder.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/ongoing_trip_card.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/planner_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/trip_section.dart';
import 'package:cinnamon_riverpod_2/features/shared/adaptive_progress_indicator.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TripsHomePage extends ConsumerWidget {
  const TripsHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<TripPlannerState> state =
        ref.watch(tripPlannerControllerProvider);

    return Scaffold(
      primary: true,
      appBar: PlannerAppBar(
        title: context.localization.trips,
        actions: [
          SizedBox(
            width: 32,
            height: 32,
            child: RoundedIconButton(
              icon: CupertinoIcons.add,
              size: 32.0,
              onPressed: () =>
                  GoRouter.of(context).push(RoutePaths.plannerCreator),
              tooltipMessage: context.localization.planNewTrip,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          data: (plannerState) {
            final currentItinerary = plannerState.currentItinerary;
            final upcomingItineraries = plannerState.upcomingItineraries;
            final pastItineraries = plannerState.pastItineraries;

            if (currentItinerary == null && upcomingItineraries.isEmpty) {
              return const Center(child: NoTripsPlaceholder());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: currentItinerary != null
                          ? OngoingTripCard(itinerary: currentItinerary)
                          : Text(
                              context.localization.currentlyNotTravelling,
                              style: context.theme.textTheme.bodyMedium,
                            ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TripSection(
                      sectionTitle:
                          '${context.localization.upcomingTrips} ${upcomingItineraries.isNotEmpty ? "(${upcomingItineraries.length})" : ""}',
                      emptyMessage: context.localization.noUpcomingTrips,
                      itineraries: upcomingItineraries,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TripSection(
                      sectionTitle:
                          '${context.localization.pastTrips} ${pastItineraries.isNotEmpty ? "(${pastItineraries.length})" : ""}',
                      emptyMessage: context.localization.noPastTrips,
                      itineraries: pastItineraries,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, _) => Text(error.toString()),
          loading: () => const Center(
            child: AdaptiveProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
