import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';

import '../data_source/traveler_data_source.dart';

final class TravelerRepositoryImpl implements TravelerRepository {
  final TravelerDataSource _travelerDataSource;

  final String _userId;

  TravelerRepositoryImpl(this._travelerDataSource, this._userId);

  @override
  Future<void> checkUsernameAvailable(String username) async {
    return _travelerDataSource.checkUsernameAvailable(username);
  }

  @override
  Future<Traveler> createProfile({required String username, required String email}) async {
    return _travelerDataSource.createTraveler(_userId, username, email).then((value) => Traveler.fromEntity(value));
  }

  @override
  Stream<Traveler> myProfile() {
    return _travelerDataSource.getTraveler(_userId).map((entity) => Traveler.fromEntity(entity));
  }
}
