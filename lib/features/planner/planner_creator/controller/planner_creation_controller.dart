import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final plannerCreationStateProvider =
    StateNotifierProvider<PlannerCreationController, PlannerCreationState>(
  (ref) => PlannerCreationController(initialState),
);

final initialState = PlannerCreationState(
  tripItinerary: TripItinerary(
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
  ),
);

class PlannerCreationController extends StateNotifier<PlannerCreationState> {
  PlannerCreationController(PlannerCreationState state) : super(state);

  void setName(String name) {
    final updatedItinerary = state.tripItinerary.copyWith(name: name);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  void setDescription(String description) {
    final updatedItinerary =
        state.tripItinerary.copyWith(description: description);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  void addLocation(TripLocation location) {
    final updatedLocations = [...state.tripItinerary.locations, location];
    final updatedItinerary =
        state.tripItinerary.copyWith(locations: updatedLocations);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  void removeLocation(String locationId) {
    final updatedLocations = state.tripItinerary.locations
        .where((location) => location.id != locationId)
        .toList();
    final updatedItinerary =
        state.tripItinerary.copyWith(locations: updatedLocations);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  void addCoTraveler(CoTraveler coTraveler) {
    final updatedTravelers =
        List<CoTraveler>.from(state.tripItinerary.travelers)..add(coTraveler);
    final updatedItinerary =
        state.tripItinerary.copyWith(travelers: updatedTravelers);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  void removeCoTraveler(String coTravelerId) {
    final updatedTravelers = state.tripItinerary.travelers
        .where((traveler) => traveler.id != coTravelerId)
        .toList();
    final updatedItinerary =
        state.tripItinerary.copyWith(travelers: updatedTravelers);
    state = state.copyWith(tripItinerary: updatedItinerary);
  }

  // TODO: Add other update methods for startDate, endDate, etc.

  Future<void> submitForm() async {
    state = state.copyWith(isSubmitting: true);
    Future.delayed(const Duration(seconds: 1));
    // TODO: Add logic to submit the `TripItinerary` to Firebase or another service
    state = state.copyWith(isSubmitting: false);
  }
}
