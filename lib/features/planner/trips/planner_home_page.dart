import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/no_trips_placeholder.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/planner_app_bar.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/trip_section.dart';
import 'package:cinnamon_riverpod_2/features/shared/adaptive_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';

class PlannerHomePage extends ConsumerWidget {
  const PlannerHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(tripPlannerControllerProvider.notifier);
    final AsyncValue<TripPlannerState> state = ref.watch(tripPlannerControllerProvider);

    return Scaffold(
      primary: true,
      appBar: PlannerAppBar(
        title: 'Trips',
        actions: [
          SizedBox(
            width: 32,
            height: 32,
            child: RoundedIconButton(
              icon: CupertinoIcons.add,
              size: 32.0,
              onPressed: controller.createMocked,
              tooltipMessage: 'Plan new trip',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: state.when(
          data: (plannerState) {
            final currentItinerary = plannerState.currentItinerary;
            final upcomingItineraries = plannerState.upcomingItineraries;

            if (currentItinerary == null && upcomingItineraries.isEmpty) {
              return const Center(child: NoTripsPlaceholder());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // TripSection(
                    //   sectionTitle: 'Current trip',
                    //   emptyMessage: 'No trip in progress',
                    //   itineraries: currentItineraries,
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                    TripSection(
                      sectionTitle:
                          'Upcoming trips ${upcomingItineraries.isNotEmpty ? "(${upcomingItineraries.length})" : ""}',
                      emptyMessage: "You don't have any upcoming trips",
                      itineraries: upcomingItineraries,
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
