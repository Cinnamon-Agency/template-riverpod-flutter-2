import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripDetailsControllerProvider =
    AsyncNotifierProvider.autoDispose.family<TripDetailsController, TripDetailsState, String>(
  () => TripDetailsController(),
);

class TripDetailsController extends AutoDisposeFamilyAsyncNotifier<TripDetailsState, String> {
  StreamSubscription<TripItinerary>? _tripItineraryStream;

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  FutureOr<TripDetailsState> build(String tripId) async {
    ref.onDispose(() {
      _tripItineraryStream?.cancel();
    });

    await _tripItineraryStream?.cancel();
    final stream = _tripRepo.getSingleTripItinerary(tripId);

    final completer = Completer<TripItinerary>();
    _tripItineraryStream = stream.listen(
      (TripItinerary event) {
        if (!completer.isCompleted) {
          completer.complete(event);
        } else {
          state = AsyncData<TripDetailsState>(
            state.requireValue.copyWith(tripItinerary: event),
          );
        }
      },
    );

    final tripItinerary = await completer.future;

    return TripDetailsState(tripItinerary: tripItinerary);
  }

  void startOrEndTrip() {}

  void selectLocation(String locationId) {
    state = AsyncData<TripDetailsState>(
      state.requireValue.copyWith(selectedLocationId: locationId),
    );
  }
}
