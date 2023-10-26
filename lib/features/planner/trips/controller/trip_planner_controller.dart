import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripPlannerControllerProvider = AutoDisposeAsyncNotifierProvider<TripPlannerController, TripPlannerState>(() {
  return TripPlannerController();
});

class TripPlannerController extends AutoDisposeAsyncNotifier<TripPlannerState> {
  StreamSubscription<List<TripItinerary>>? _trips;

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  FutureOr<TripPlannerState> build() async {
    ref.keepAlive();

    ref.onDispose(() {
      _trips?.cancel();
    });


    Future(() async {
      state = AsyncLoading();
      await _trips?.cancel();

      _trips = ref.watch(tripRepositoryProvider).getTripItineraries().listen((event) {
        state = AsyncData(TripPlannerState(itineraries: event.toList()));
      });
    });

    return TripPlannerState(itineraries: []);
  }

  Future<void> createMocked() async {
    await _tripRepo.createMocked();
  }
}
