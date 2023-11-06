import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripDetailsControllerProvider =
    AsyncNotifierProvider.autoDispose.family<TripDetailsController, TripDetailsState, TripItinerary>(
  () => TripDetailsController(),
);

class TripDetailsController extends AutoDisposeFamilyAsyncNotifier<TripDetailsState, TripItinerary> {
  StreamSubscription<TripItinerary>? _tripItineraryStream;

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  TripDetailsState build(TripItinerary arg) {
    ref.onDispose(() {
      _tripItineraryStream?.cancel();
    });

    Future<void>(() async {
      await _tripItineraryStream?.cancel();

      _tripItineraryStream = _tripRepo.getSingleTripItinerary(arg.id).listen(
        (TripItinerary event) {
          state = AsyncData<TripDetailsState>(
            state.requireValue.copyWith(tripItinerary: event),
          );
        },
      );
    });

    return TripDetailsState(tripItinerary: arg);
  }

  void startOrEndTrip() {}

  void selectLocation(String locationId) {
    state = AsyncData<TripDetailsState>(
      state.requireValue.copyWith(selectedLocationId: locationId),
    );
  }
}
