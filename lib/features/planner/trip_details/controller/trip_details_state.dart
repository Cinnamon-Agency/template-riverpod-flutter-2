import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:equatable/equatable.dart';

class TripDetailsState extends Equatable {
  final TripItinerary tripItinerary;
  final String? selectedLocationId;

  const TripDetailsState({
    required this.tripItinerary,
    this.selectedLocationId,
  });

  TripDetailsState copyWith({
    TripItinerary? tripItinerary,
    String? selectedLocationId,
  }) =>
      TripDetailsState(
        tripItinerary: tripItinerary ?? this.tripItinerary,
        selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      );

  @override
  List<Object?> get props => <dynamic>[tripItinerary, selectedLocationId];
}
