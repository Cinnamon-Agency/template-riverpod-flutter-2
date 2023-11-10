import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_itinerary.dart';
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
  final DateTime startDate;
  final DateTime endDate;
  final bool isOngoing;
  final bool hasEnded;

  const TripItinerary({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.locations,
    required this.travelers,
    required this.startDate,
    required this.endDate,
    this.isOngoing = false,
    this.hasEnded = false,
  });

  factory TripItinerary.fromEntity(TripItineraryEntity entity, List<TravelerEntity> travelers) {
    return TripItinerary(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      locations: entity.locations.map((e) => TripLocation.fromEntity(e)).toList(),
      travelers: travelers.map((e) => CoTraveler.fromEntity(e)).toList(),
      startDate: entity.startDate,
      endDate: entity.endDate,
      isOngoing: entity.isOngoing,
      hasEnded: entity.hasEnded,
    );
  }

  TripItinerary copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<TripLocation>? locations,
    List<CoTraveler>? travelers,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    bool? hasEnded,
  }) {
    return TripItinerary(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      locations: locations ?? this.locations,
      travelers: travelers ?? this.travelers,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isOngoing: isOngoing ?? this.isOngoing,
      hasEnded: hasEnded ?? this.hasEnded,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, description, imageUrl, locations, travelers, startDate, endDate, isOngoing, hasEnded];

  bool get isUpcoming {
    final now = DateTime.now();

    return now.isBefore(startDate);
  }

  /// Returns the current `TripLocation` in an ongoing trip,
  /// or `null` if trip has ended or all locations were visited.
  TripLocation? get currentLocation {
    if (hasEnded) {
      // Trip has ended, no more locations to visit
      return null;
    } else {
      // Trip is still ongoing
      // Current location is the first one that hasn't been visited, or null if all were visited
      final currentLocationIndex = isOngoing ? locations.indexWhere((location) => !location.isVisited) : -1;
      return currentLocationIndex == -1 ? null : locations[currentLocationIndex];
    }
  }

  /// Returns the next `TripLocation` in an ongoing trip,
  /// or `null` if trip has ended or there are no more locations to visit.
  TripLocation? get nextLocation {
    if (hasEnded) {
      // Trip has ended, no more locations to visit
      return null;
    } else {
      // Trip is still ongoing
      // Next location is the one after current one, or null if the current location is last
      final currentLocationIndex = isOngoing ? locations.indexWhere((location) => !location.isVisited) : -1;
      return currentLocationIndex + 1 == locations.length ? null : locations[currentLocationIndex + 1];
    }
  }
}
