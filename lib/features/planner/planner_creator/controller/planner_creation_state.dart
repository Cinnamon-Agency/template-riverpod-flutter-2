import 'package:cinnamon_riverpod_2/infra/traveler/model/cotraveler.dart';
import 'package:equatable/equatable.dart';

class PlannerCreationState extends Equatable {
  final List<CoTraveler> coTravelers;

  const PlannerCreationState({
    required this.coTravelers,
  });

  PlannerCreationState copyWith({List<CoTraveler>? coTravelers}) {
    return PlannerCreationState(
      coTravelers: coTravelers ?? this.coTravelers,
    );
  }

  @override
  List<Object?> get props => <Object?>[coTravelers];
}
