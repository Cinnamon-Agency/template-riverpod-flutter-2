import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:equatable/equatable.dart';

class TripTimerState extends Equatable {
  final TripLocation currentLocation;
  final Duration remainingTime;
  final bool timeUp;
  const TripTimerState({
    required this.currentLocation,
    required this.remainingTime,
    required this.timeUp,
  });

  @override
  List<Object?> get props => [currentLocation, remainingTime, timeUp];

  TripTimerState copyWith({
    TripLocation? currentLocation,
    Duration? remainingTime,
    bool? timeUp,
  }) {
    return TripTimerState(
      currentLocation: currentLocation ?? this.currentLocation,
      remainingTime: remainingTime ?? this.remainingTime,
      timeUp: timeUp ?? this.timeUp,
    );
  }
}
