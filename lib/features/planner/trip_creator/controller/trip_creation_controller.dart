import 'dart:async';

import 'package:cinnamon_riverpod_2/features/planner/trip_creator/controller/trip_creation_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final tripCreationStateProvider = AutoDisposeAsyncNotifierProvider<TripCreationController, TripCreationState>(
  () => TripCreationController(),
);

class TripCreationController extends AutoDisposeAsyncNotifier<TripCreationState> {
  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  String get _userId => ref.read(userIdProvider);

  Future<void> createTripItinerary(Map<String, dynamic> formData) async {
    state = const AsyncLoading<TripCreationState>();
    try {
      await _tripRepo.createTripItinerary(TripItineraryEntity(
        id: '',
        name: formData['name'],
        description: formData['description'],
        locations: [...state.requireValue.tripLocations.map((e) => TripLocationEntity.fromTripLocation(e))],
        imageUrl:
            'https://images.unsplash.com/photo-1572455044327-7348c1be7267?auto=format&fit=crop&q=80&w=3603&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        startDate: DateTime.now().add(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 35)),
        ownerIds: [_userId, ...state.requireValue.coTravelers.values.map((e) => e.id)],
      ));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> updateTripItinerary(TripItinerary updatedTripItinerary) async {
    state = const AsyncLoading<TripCreationState>();
    try {
      await _tripRepo.updateTripItineraryData(updatedTripItinerary);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  void addCoTraveler(String key, CoTraveler newCoTraveler) {
    Map<String, CoTraveler> tmp = Map.from(state.requireValue.coTravelers);
    tmp[key] = newCoTraveler;
    state = AsyncData(state.requireValue.copyWith(coTravelers: tmp));
  }

  void removeCoTraveler(String key) {
    Map<String, CoTraveler> tmp = Map.from(state.requireValue.coTravelers);
    tmp.remove(key);
    state = AsyncData(state.requireValue.copyWith(coTravelers: tmp));
  }

  void updateCoTravelerName(String key, String id, String name) {
    Map<String, CoTraveler> tmp = Map.from(state.requireValue.coTravelers);
    tmp.update(key, (value) => CoTraveler(id: id, name: name));
    state = AsyncData(state.requireValue.copyWith(coTravelers: tmp));
  }

  void addTripLocation(TripLocation location) {
    state = AsyncData(state.requireValue.copyWith(
      tripLocations:
          state.requireValue.tripLocations.isEmpty ? [location] : [...state.requireValue.tripLocations, location],
    ));
  }

  void updateTripLocation(TripLocation location) {
    state = AsyncData(state.requireValue.copyWith(
      tripLocations: state.requireValue.tripLocations.map((loc) => loc.id == location.id ? location : loc).toList(),
    ));
  }

  void removeTripLocation(String id) {
    state = AsyncData(state.requireValue.copyWith(
      tripLocations: state.requireValue.tripLocations.whereNot((ct) => id == ct.id).toList(),
    ));
  }

  void setInitialValuesWhenEditing(Uuid uuid, TripItinerary editTripItinerary) {
    Map<String, CoTraveler> tmp = {};
    for (var traveler in editTripItinerary.travelers) {
      tmp[uuid.v4()] = traveler;
    }
    tmp.removeWhere((key, value) => value.id == _userId);
    state = AsyncData(state.requireValue.copyWith(
      coTravelers: tmp,
      tripLocations: editTripItinerary.locations,
    ));
  }

  void removeUserTrips() => _tripRepo.removeUserTrips();

  void setError(String s) {
    state = AsyncError(s, StackTrace.current);
  }

  void resetState() {
    state = const AsyncData(TripCreationState(
      coTravelers: {},
      tripLocations: [],
    ));
  }

  @override
  FutureOr<TripCreationState> build() => const TripCreationState(
        coTravelers: {},
        tripLocations: [],
      );
}
