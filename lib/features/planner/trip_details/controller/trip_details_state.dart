import 'package:equatable/equatable.dart';

class TripDetailsState extends Equatable {
  const TripDetailsState({
    this.selectedLocationId,
  });

  final String? selectedLocationId;

  TripDetailsState copyWith({
    String? selectedLocationId,
  }) =>
      TripDetailsState(
        selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      );

  @override
  List<Object?> get props => <dynamic>[selectedLocationId];
}
