import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final plannerCreationStateProvider =
    AsyncNotifierProvider<PlannerCreationController, PlannerCreationState>(
  () => PlannerCreationController(),
);

final TripItinerary defaultTripItinerary = TripItinerary(
  id: '',
  name: '',
  description: '',
  imageUrl: null,
  locations: const [],
  travelers: const [],
  startDate: DateTime.now(),
  endDate: DateTime.now(),
  isOngoing: false,
  hasEnded: false,
);

/// TODO: Refactor controller to only handle sending form data
class PlannerCreationController extends AsyncNotifier<PlannerCreationState> {
  Future<void> createTripItinerary(TripItineraryEntity tripItinerary) async {
    state = const AsyncLoading<PlannerCreationState>();
    // await _tripRepo.createTripItinerary(tripItinerary);
    await Future.delayed(Duration(seconds: 3));
    state = AsyncData(state.requireValue);
  }

  void updateCoTravelersCount(int count) =>
      state = AsyncData(PlannerCreationState(coTravelersCount: count));

  @override
  FutureOr<PlannerCreationState> build() =>
      const PlannerCreationState(coTravelersCount: 0);
}
