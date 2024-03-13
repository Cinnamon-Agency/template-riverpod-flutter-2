import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:equatable/equatable.dart';

class TripDetailsState extends Equatable {
  final TripItinerary tripItinerary;
  final TripLocation? currentLocation;
  final TripLocation? nextLocation;

  const TripDetailsState({
    required this.tripItinerary,
    this.currentLocation,
    this.nextLocation,
  });

  TripDetailsState copyWith({
    TripItinerary? tripItinerary,
    String? selectedLocationId,
    TripLocation? currentLocation,
    TripLocation? nextLocation,
  }) =>
      TripDetailsState(
        tripItinerary: tripItinerary ?? this.tripItinerary,
        currentLocation: currentLocation ?? this.currentLocation,
        nextLocation: nextLocation ?? this.nextLocation,
      );

  /// Copy the `TripDetailsState` with the given arguments.
  /// However, unlike the 'traditional' `copyWith` method,
  /// this will set location properties to `null` if
  /// [currentLocation] and [nextLocation] are `null` or are not passed.
  ///
  /// Default `copyWith` method would, in that case, copy the old value,
  /// resulting in an unwanted state.
  TripDetailsState copyWithNullableLocations({
    TripItinerary? tripItinerary,
    String? selectedLocationId,
    TripLocation? currentLocation,
    TripLocation? nextLocation,
  }) =>
      TripDetailsState(
        tripItinerary: tripItinerary ?? this.tripItinerary,
        currentLocation: currentLocation,
        nextLocation: nextLocation,
      );

  @override
  List<Object?> get props => <dynamic>[tripItinerary, currentLocation, nextLocation];
}
