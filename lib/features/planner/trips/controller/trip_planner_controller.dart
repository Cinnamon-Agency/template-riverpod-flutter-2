import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeAsyncNotifierProvider<TripPlannerController, TripPlannerState>
    tripPlannerControllerProvider =
    AutoDisposeAsyncNotifierProvider<TripPlannerController, TripPlannerState>(
        () => TripPlannerController());

class TripPlannerController extends AutoDisposeAsyncNotifier<TripPlannerState> {
  StreamSubscription<List<TripItinerary>>? _trips;

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  FutureOr<TripPlannerState> build() async {
    ref.keepAlive();

    ref.onDispose(() {
      _trips?.cancel();
    });

    Future<void>(() async {
      state = const AsyncLoading<TripPlannerState>();
      await _trips?.cancel();

      _trips = ref
          .watch(tripRepositoryProvider)
          .getTripItineraries()
          .listen((List<TripItinerary> event) {
        state = AsyncData<TripPlannerState>(
            TripPlannerState(itineraries: event.toList()));
      });
    });

    return const TripPlannerState(itineraries: <TripItinerary>[]);
  }

  Future<void> createMocked() async {
    await _tripRepo.createMocked();
  }
}
