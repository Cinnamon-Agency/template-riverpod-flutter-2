import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripPlannerControllerProvider = AsyncNotifierProvider<TripPlannerController, TripPlannerState>(() {
  return TripPlannerController();
});

class TripPlannerController extends AsyncNotifier<TripPlannerState> {
  StreamSubscription<List<TripItinerary>>? trips;


  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  FutureOr<TripPlannerState> build() async {
    Future(() async {
      state = AsyncLoading();
      await trips?.cancel();

      trips = ref.watch(tripRepositoryProvider).getTripItineraries().listen((event) {
        state = AsyncData(TripPlannerState(itineraries: event.toList()));
      });
    });

    return TripPlannerState(itineraries: []);
  }



  Future<void> createMocked()async{
    await _tripRepo.createMocked();
  }
}
