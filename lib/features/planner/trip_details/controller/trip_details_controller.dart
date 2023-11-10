import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
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
  FutureOr<TripDetailsState> build(String arg) async {
    ref.onDispose(() {
      _tripItineraryStream?.cancel();
    });

    await _tripItineraryStream?.cancel();
    final stream = _tripRepo.getSingleTripItinerary(arg);

    final completer = Completer<TripItinerary>();
    _tripItineraryStream = stream.listen(
      (TripItinerary event) {
        if (!completer.isCompleted) {
          completer.complete(event);
        } else {
          state = AsyncData<TripDetailsState>(
            state.requireValue.copyWithNullableLocations(
              tripItinerary: event,
              currentLocation: event.currentLocation,
              nextLocation: event.nextLocation,
            ),
          );
        }
      },
    );

    final tripItinerary = await completer.future;

    return TripDetailsState(
      tripItinerary: tripItinerary,
      currentLocation: tripItinerary.currentLocation,
      nextLocation: tripItinerary.nextLocation,
    );
  }

  /// Starts or ends the current trip, depending on its current status.
  ///
  /// If ending a trip, this also marks all trip locations as visited.
  Future<void> startOrEndTrip() async {
    final isOngoing = state.requireValue.tripItinerary.isOngoing;

    TripItinerary updatedTripItinerary;

    if (isOngoing) {
      // Set all locations as visited
      final updatedLocations = state.requireValue.tripItinerary.locations
          .map((location) => location.copyWith(
                isVisited: true,
              ))
          .toList();
      updatedTripItinerary = state.requireValue.tripItinerary.copyWith(
        isOngoing: false,
        hasEnded: true,
        locations: updatedLocations,
      );
    } else {
      // Start the trip
      updatedTripItinerary = state.requireValue.tripItinerary.copyWith(isOngoing: true);
    }

    await _tripRepo.updateTripItineraryData(updatedTripItinerary);
  }

  /// Moves to the next trip location, if it exists.
  ///
  /// In case the next location doesn't exists,
  /// the trip has reached its end and is marked as ended.
  Future<void> moveToNextLocation() async {
    List<TripLocation> updatedLocations = state.requireValue.tripItinerary.locations;

    int updatedLocationIndex = 0;

    if (state.requireValue.currentLocation != null) {
      updatedLocationIndex = updatedLocations.indexOf(state.requireValue.currentLocation!);
    }

    final currentLocation = updatedLocations[updatedLocationIndex];

    updatedLocations[updatedLocationIndex] = currentLocation.copyWith(isVisited: true);

    final hasReachedEnd = state.requireValue.nextLocation == null;

    TripItinerary updatedTripItinerary = state.requireValue.tripItinerary.copyWith(
      locations: updatedLocations,
      hasEnded: hasReachedEnd,
      isOngoing: !hasReachedEnd,
    );

    await _tripRepo.updateTripItineraryData(updatedTripItinerary);
  }

  /// Selects a trip location with ID [locationId].
  void selectLocation(String locationId) {
    TripLocation selectedLocation =
        state.requireValue.tripItinerary.locations.firstWhere((location) => location.id == locationId);

    state = AsyncData<TripDetailsState>(
      state.requireValue.copyWith(currentLocation: selectedLocation),
    );
  }
}
