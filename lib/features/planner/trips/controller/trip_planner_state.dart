import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:equatable/equatable.dart';

class TripPlannerState extends Equatable {
  final List<TripItinerary> itineraries;
  final List<TripItinerary> upcomingItineraries;

  const TripPlannerState({
    required this.itineraries,
    required this.upcomingItineraries,
  });

  @override
  List<Object?> get props => [itineraries, upcomingItineraries];
}
