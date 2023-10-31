import 'package:cinnamon_riverpod_2/features/account/controller/account_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountControllerProvider =
    AutoDisposeAsyncNotifierProvider<AccountController, AccountState>(
  () => AccountController(),
);

class AccountController extends AutoDisposeAsyncNotifier<AccountState> {
  FirebaseAuthService get _authService => ref.read(authServiceProvider);

  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  Future<void> updateProfileData({required bool sendPushNotifications}) async {
    await _travelerRepo.updateProfileData(<String, dynamic>{
      'sendPushNotifications': sendPushNotifications,
    });
    state = AsyncData(AccountState(notificationsFlag: sendPushNotifications));
  }

  Future<void> deleteUserAccount() async {
    state = const AsyncLoading();

    try {
      await _authService.deleteAccount().then((_) => _travelerRepo
          .deleteProfile()
          .then((_) => _tripRepo.removeUserTrips()));
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
    state = const AsyncData(AccountState());
  }

  Future<bool> logOut() async {
    state = const AsyncLoading();

    await _authService.logout();

    state = const AsyncData(AccountState());
    return _authService.auth.currentUser == null;
  }

  @override
  AccountState build() {
    return AccountState(
        notificationsFlag:
            ref.watch(profileDataProvider).value?.sendPushNotifications ??
                false);
  }
}
