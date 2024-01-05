import 'dart:developer';

import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class TripRepositoryImplementation with EquatableMixin implements TripRepository {
  TripRepositoryImplementation(this._tripDataSource, this._travelerDataSource, this._userId) {
    log("build repository for $_userId");
  }

  final TripDataSource _tripDataSource;
  final TravelerDataSource _travelerDataSource;
  final String _userId;

  final Uuid uuid = const Uuid();

  @override
  Stream<List<TripItinerary>> getTripItineraries() {
    return _tripDataSource.getTripItineraries(_userId).asyncMap((List<TripItineraryEntity> entities) async {
      return Future.wait(entities.map((TripItineraryEntity entity) async {
        final List<Future<TravelerEntity>> travelers = entity.ownerIds.map((String id) async {
          return _travelerDataSource.getTraveler(id);
        }).toList();
        final List<TravelerEntity> awaited = await Future.wait(travelers);
        return TripItinerary.fromEntity(entity, awaited);
      }));
    });
  }

  @override
  Stream<TripItinerary> getSingleTripItinerary(String itineraryId) {
    return _tripDataSource.getSingleTripItinerary(itineraryId).asyncMap((TripItineraryEntity entity) async {
      final List<Future<TravelerEntity>> travelers = entity.ownerIds.map((String id) async {
        return _travelerDataSource.getTraveler(id);
      }).toList();
      final List<TravelerEntity> awaited = await Future.wait(travelers);
      return TripItinerary.fromEntity(entity, awaited);
    });
  }

  @override
  Future<void> updateTripItineraryData(TripItinerary tripItinerary) {
    return _tripDataSource.updateTripItineraryData(TripItineraryEntity.fromTripItinerary(tripItinerary));
  }

  @override
  Future<void> createMocked() {
    final tripLocations = <TripLocationEntity>[
      TripLocationEntity(
        id: uuid.v4(),
        name: 'Jelačić Square',
        duration: const Duration(minutes: 30),
        location: const LatLng(45.8130174, 15.9748084),
        isVisited: false,
      ),
      TripLocationEntity(
        id: uuid.v4(),
        name: 'Zagreb Cathedral',
        duration: const Duration(minutes: 15),
        location: const LatLng(45.8145063, 15.9772224),
        isVisited: false,
      ),
      TripLocationEntity(
        id: uuid.v4(),
        name: 'Botanical Garden',
        duration: const Duration(hours: 1),
        location: const LatLng(45.8046817, 15.971232),
        isVisited: false,
      ),
      TripLocationEntity(
        id: uuid.v4(),
        name: 'Cinnamon Agency',
        duration: const Duration(hours: 2),
        location: const LatLng(45.7932095, 15.9674974),
        isVisited: false,
      ),
      TripLocationEntity(
        id: uuid.v4(),
        name: 'Lake Jarun',
        duration: const Duration(hours: 3, minutes: 30),
        location: const LatLng(45.7821919, 15.9237076),
        isVisited: false,
      ),
    ];

    return _tripDataSource.createTrip(
      TripItineraryEntity(
        id: uuid.v4(),
        name: "Trip to Zagreb",
        description: "Going to ZG, HR",
        locations: tripLocations,
        ownerIds: <String>[_userId],
        imageUrl:
            'https://images.unsplash.com/photo-1572455044327-7348c1be7267?auto=format&fit=crop&q=80&w=3603&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 15),
      ),
    );
  }

  @override
  Future<void> removeUserTrips() => _tripDataSource.removeUserTrips(_userId);

  @override
  List<Object?> get props => <Object?>[_userId];

  @override
  Future<void> createTripItinerary(TripItineraryEntity tripItinerary) =>
      _tripDataSource.createTrip(tripItinerary);


}
