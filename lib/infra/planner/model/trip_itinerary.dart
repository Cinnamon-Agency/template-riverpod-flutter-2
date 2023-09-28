import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:equatable/equatable.dart';

class TripItinerary extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<TripLocation> locations;
  final List<CoTraveler> travelers;

  TripItinerary({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.locations,
    required this.travelers,
  });

  factory TripItinerary.fromEntity(TripItineraryEntity entity, List<TravelerEntity> travelers) {
    return TripItinerary(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      locations: entity.locations.map((e) => TripLocation.fromEntity(e)).toList(),
      travelers: travelers.map((e) => CoTraveler.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, description, imageUrl, locations, travelers];
}
