import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/planner_creator/controller/planner_creation_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final plannerCreationStateProvider =
    AsyncNotifierProvider<PlannerCreationController, PlannerCreationState>(
  () => PlannerCreationController(),
);

/// TODO: Refactor controller to only handle sending form data
class PlannerCreationController extends AsyncNotifier<PlannerCreationState> {
  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  String get _userId => ref.read(userIdProvider);

  Future<void> createTripItinerary(Map<String, dynamic> formData) async {
    state = const AsyncLoading<PlannerCreationState>();
    try {
      await _tripRepo.createTripItinerary(TripItineraryEntity(
        id: '',
        name: formData['name'],
        description: formData['description'],
        locations: [],
        imageUrl:
            'https://images.unsplash.com/photo-1572455044327-7348c1be7267?auto=format&fit=crop&q=80&w=3603&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        startDate: DateTime(5243523462345624, 2, 1),
        endDate: DateTime(2024, 2, 15),
        ownerIds: [_userId, ...state.requireValue.coTravelers.map((e) => e.id)],
      ));
      state = AsyncData(state.requireValue);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void addCoTraveler(CoTraveler newCoTraveler) {
    state = AsyncData(state.requireValue.copyWith(
      coTravelers: [...state.requireValue.coTravelers, newCoTraveler],
    ));
  }

  void removeCoTraveler(String id) {
    state = AsyncData(state.requireValue.copyWith(
      coTravelers:
          state.requireValue.coTravelers.whereNot((ct) => id == ct.id).toList(),
    ));
  }

  void updateCoTravelerName(String id, String name) {
    state = AsyncData(state.requireValue.copyWith(
      coTravelers: state.requireValue.coTravelers
          .map((c) => c.id == id ? c.copyWith(name: name) : c)
          .toList(),
    ));
  }

  void addTripLocation(TripLocation location) {
    state = AsyncData(state.requireValue.copyWith(
      tripLocations: [...state.requireValue.tripLocations, location],
    ));
  }

  void removeTripLocation(String id) {
    state = AsyncData(state.requireValue.copyWith(
      tripLocations: state.requireValue.tripLocations
          .whereNot((ct) => id == ct.id)
          .toList(),
    ));
  }

  void removeUserTrips() => _tripRepo.removeUserTrips();

  void setError(String s) {
    state = AsyncValue.error(s, StackTrace.current);
  }

  @override
  FutureOr<PlannerCreationState> build() => const PlannerCreationState(
        coTravelers: [],
        tripLocations: [],
      );
}
