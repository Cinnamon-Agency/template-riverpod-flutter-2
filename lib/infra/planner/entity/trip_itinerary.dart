import 'package:cinnamon_riverpod_2/infra/planner/entity/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripItineraryEntity {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<TripLocationEntity> locations;
  final List<String> ownerIds;
  final DateTime startDate;
  final DateTime endDate;
  final bool isOngoing;
  final bool hasEnded;

  const TripItineraryEntity({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.locations,
    required this.ownerIds,
    required this.startDate,
    required this.endDate,
    this.isOngoing = false,
    this.hasEnded = false,
  });

  factory TripItineraryEntity.fromDoc(DocumentSnapshot d) {
    var doc = d.data() as Map<String, dynamic>;
    return TripItineraryEntity(
      id: d.id,
      name: doc['name'],
      description: doc['description'],
      imageUrl: doc['imageUrl'],
      locations: (doc['locations'] as List).map((e) => TripLocationEntity.fromMap(e)).toList(),
      ownerIds: (doc['ownerIds'] as List).map((e) => e.toString()).toList(),
      startDate: DateTime.tryParse(doc['startDate'].toString()) ?? DateTime.now(),
      endDate: DateTime.tryParse(doc['endDate'].toString()) ?? DateTime.now(),
      isOngoing: doc['isOngoing'] as bool,
      hasEnded: doc['hasEnded'] as bool,
    );
  }

  /// Maps the given [tripItinerary] app data model to its [TripItineraryEntity],
  /// for interfacing with a data source.
  factory TripItineraryEntity.fromTripItinerary(TripItinerary tripItinerary) {
    return TripItineraryEntity(
      id: tripItinerary.id,
      name: tripItinerary.name,
      description: tripItinerary.description,
      imageUrl: tripItinerary.imageUrl,
      locations: tripItinerary.locations.map((location) => TripLocationEntity.fromTripLocation(location)).toList(),
      ownerIds: tripItinerary.travelers.map((owner) => owner.id).toList(),
      startDate: tripItinerary.startDate,
      endDate: tripItinerary.endDate,
      isOngoing: tripItinerary.isOngoing,
      hasEnded: tripItinerary.hasEnded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'locations': locations.map((e) => e.toMap()).toList(),
      'ownerIds': ownerIds,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isOngoing': isOngoing,
      'hasEnded': hasEnded,
    };
  }
}
