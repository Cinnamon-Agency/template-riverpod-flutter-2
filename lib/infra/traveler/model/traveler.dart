import 'package:equatable/equatable.dart';

import '../entity/traveler_entity.dart';

class Traveler extends Equatable {
  final String name;

  Traveler(this.name);

  factory Traveler.fromEntity(TravelerEntity entity) {
    return Traveler(entity.name);
  }

  @override
  List<Object?> get props => [name];
}
