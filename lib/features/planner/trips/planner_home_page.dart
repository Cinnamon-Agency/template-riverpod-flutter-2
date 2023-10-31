import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_controller.dart';
import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlannerHomePage extends ConsumerWidget {
  const PlannerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<TripPlannerState> state =
        ref.watch(tripPlannerControllerProvider);
    return Scaffold(
      primary: false,
      floatingActionButton: FloatingActionButton(
        onPressed:
            ref.read(tripPlannerControllerProvider.notifier).createMocked,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: state.when(
          data: (TripPlannerState data) => data.itineraries.isNotEmpty
              ? SingleChildScrollView(
                  child: Text(state.toString()),
                )
              : const Text('Such empty'),
          error: (Object error, StackTrace stackTrace) =>
              const Text('Error occurred.'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
