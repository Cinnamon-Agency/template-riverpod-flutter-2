import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'controller/trip_planner_controller.dart';

class PlannerHomePage extends ConsumerWidget {
  const PlannerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tripPlannerControllerProvider);
    return Scaffold(
        primary: false,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(tripPlannerControllerProvider.notifier).createMocked();
          },
          child: const Icon(Icons.add),
        ),
        body: Text(state.toString()));
  }
}
