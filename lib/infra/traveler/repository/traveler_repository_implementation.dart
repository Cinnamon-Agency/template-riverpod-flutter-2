import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';

import '../data_source/traveler_data_source.dart';

final class TravelerRepositoryImpl implements TravelerRepository {
  final TravelerDataSource _travelerDataSource;

  final String _userId;

  TravelerRepositoryImpl(this._travelerDataSource, this._userId);

  @override
  Future<Traveler> getProfile() {
    return _travelerDataSource.getTraveler(_userId).then((value) => Traveler.fromEntity(value));

  }



}



