import 'package:cinnamon_riverpod_2/infra/traveler/entity/traveler_entity.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/model/traveler.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:equatable/equatable.dart';

import '../data_source/traveler_data_source.dart';

final class TravelerRepositoryImpl with EquatableMixin implements TravelerRepository {
  final TravelerDataSource _travelerDataSource;

  final String _userId;

  TravelerRepositoryImpl(this._travelerDataSource, this._userId);

  @override
  Future<void> checkUsernameAvailable(String username) async {
    return _travelerDataSource.checkUsernameAvailable(username);
  }

  @override
  Future<Traveler> createProfile({
    required String username,
    required String email,
    bool sendPushNotifications = false,
  }) async {
    return _travelerDataSource
        .createTraveler(
          userId: _userId,
          username: username,
          email: email,
          sendPushNotifications: sendPushNotifications,
        )
        .then((TravelerEntity value) => Traveler.fromEntity(value));
  }

  @override
  Future<Traveler> getProfileData() async {
    return Traveler.fromEntity(await _travelerDataSource.getTraveler(_userId));
  }

  @override
  List<Object?> get props => [_userId];

  @override
  Future<void> updatePushNotificationsFlag(bool flag) =>
      _travelerDataSource.updatePushNotificationsFlag(flag);
}
