import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:equatable/equatable.dart';

class PlannerCreationState extends Equatable {
  final TripItinerary tripItinerary;
  final bool isSubmitting;

  const PlannerCreationState({
    required this.tripItinerary,
    this.isSubmitting = false,
  });

  PlannerCreationState copyWith({
    TripItinerary? tripItinerary,
    bool? isSubmitting,
  }) =>
      PlannerCreationState(
          tripItinerary: tripItinerary ?? this.tripItinerary,
          isSubmitting: isSubmitting ?? this.isSubmitting);

  @override
  List<Object?> get props => <Object?>[tripItinerary, isSubmitting];
}
