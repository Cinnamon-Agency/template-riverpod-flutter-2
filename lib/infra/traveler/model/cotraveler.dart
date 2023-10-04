import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:equatable/equatable.dart';

class CoTraveler extends Equatable {
  final String name;

  CoTraveler(this.name);

  factory CoTraveler.fromEntity(TravelerEntity entity) {
    return CoTraveler(entity.username);
  }

  @override
  List<Object?> get props => [name];
}
