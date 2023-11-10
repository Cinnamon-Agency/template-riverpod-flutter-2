import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:equatable/equatable.dart';

class TripPlannerState extends Equatable {
  final List<TripItinerary> upcomingItineraries;
  final List<TripItinerary> pastItineraries;
  final TripItinerary? currentItinerary;

  const TripPlannerState({
    required this.upcomingItineraries,
    required this.pastItineraries,
    this.currentItinerary,
  });

  @override
  List<Object?> get props => [upcomingItineraries, pastItineraries, currentItinerary];
}
