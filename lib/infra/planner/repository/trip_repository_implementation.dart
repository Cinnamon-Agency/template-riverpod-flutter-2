import 'dart:developer';

import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:equatable/equatable.dart';

class TripRepositoryImplementation with EquatableMixin implements TripRepository {
  TripRepositoryImplementation(
      this._tripDataSource, this._travelerDataSource, this._userId) {
    log("build repository for $_userId");
  }

  final TripDataSource _tripDataSource;
  final TravelerDataSource _travelerDataSource;
  final String _userId;

  @override
  Stream<List<TripItinerary>> getTripItineraries() {
    return _tripDataSource
        .getTripItineraries(_userId)
        .asyncMap((List<TripItineraryEntity> entities) async {
      return Future.wait(entities.map((TripItineraryEntity entity) async {
        final List<Future<TravelerEntity>> travelers =
            entity.ownerIds.map((String id) async {
          return _travelerDataSource.getTraveler(id);
        }).toList();
        final List<TravelerEntity> awaited = await Future.wait(travelers);
        return TripItinerary.fromEntity(entity, awaited);
      }));
    });
  }

  @override
  List<Object?> get props => <Object?>[_userId];

  @override
  Future<void> createMocked() {
    return _tripDataSource.createTrip(
      TripItineraryEntity(
          id: "id",
          name: "name",
          description: "description",
          locations: <TripLocationEntity>[],
          ownerIds: <String>[_userId]),
    );
  }

  @override
  Future<void> removeUserTrips() => _tripDataSource.removeUserTrips(_userId);
}
