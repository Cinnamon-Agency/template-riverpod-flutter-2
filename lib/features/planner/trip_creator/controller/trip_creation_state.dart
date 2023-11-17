import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:equatable/equatable.dart';

class TripCreationState extends Equatable {
  final Map<String, CoTraveler> coTravelers;
  final List<TripLocation> tripLocations;

  const TripCreationState({
    required this.coTravelers,
    required this.tripLocations,
  });

  TripCreationState copyWith({
    Map<String, CoTraveler>? coTravelers,
    List<TripLocation>? tripLocations,
  }) {
    return TripCreationState(
      coTravelers: coTravelers ?? this.coTravelers,
      tripLocations: tripLocations ?? this.tripLocations,
    );
  }

  @override
  List<Object?> get props => <Object?>[coTravelers, tripLocations];
}
