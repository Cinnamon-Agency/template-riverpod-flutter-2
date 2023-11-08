import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:equatable/equatable.dart';

class CoTraveler extends Equatable {
  final String id;
  final String name;

  const CoTraveler({
    required this.id,
    required this.name,
  });

  factory CoTraveler.fromEntity(TravelerEntity entity) {
    return CoTraveler(
      id: entity.id,
      name: entity.username,
    );
  }

  @override
  List<Object?> get props => [name];
}
