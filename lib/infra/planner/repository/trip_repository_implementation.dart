import 'package:cinnamon_riverpod_2/infra/planner/data_source/trip_data_source.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/data_source/traveler_data_source.dart';

class TripRepositoryImplementation implements TripRepository {
  final TripDataSource _tripDataSource;
  final TravelerDataSource _travelerDataSource;
  final String _userId;
  TripRepositoryImplementation(this._tripDataSource, this._travelerDataSource, this._userId);

  @override
  Stream<List<TripItinerary>> getTripItineraries() {
    return _tripDataSource.getTripItineraries(_userId).asyncMap((entities) async {
      return Future.wait(entities.map((entity) async {
        final travelers = entity.ownerIds.map((id) async {
          return _travelerDataSource.getTraveler(id).first;
        }).toList();
        final awaited = await Future.wait(travelers);
        return TripItinerary.fromEntity(entity, awaited);
      }));
    });
  }
}
