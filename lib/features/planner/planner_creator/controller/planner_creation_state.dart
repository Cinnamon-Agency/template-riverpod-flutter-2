import 'package:equatable/equatable.dart';

class PlannerCreationState extends Equatable {
  final int? coTravelersCount;

  const PlannerCreationState({
    required this.coTravelersCount,
  });

  @override
  List<Object?> get props => <Object?>[coTravelersCount];
}
