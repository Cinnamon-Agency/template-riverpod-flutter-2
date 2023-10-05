import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:equatable/equatable.dart';

class TripPlannerState extends Equatable {
  final List<TripItinerary> itineraries;

  const TripPlannerState({
    required this.itineraries,
  });

  @override
  List<Object?> get props => [itineraries];
}
