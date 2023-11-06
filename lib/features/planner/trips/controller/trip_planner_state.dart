import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:equatable/equatable.dart';

class TripPlannerState extends Equatable {
  final List<TripItinerary> upcomingItineraries;
  final TripItinerary? currentItinerary;

  const TripPlannerState({
    required this.upcomingItineraries,
    this.currentItinerary,
  });

  @override
  List<Object?> get props => [upcomingItineraries, currentItinerary];
}
