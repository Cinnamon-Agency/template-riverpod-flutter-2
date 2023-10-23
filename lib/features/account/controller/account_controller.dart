import 'package:app_settings/app_settings.dart';
import 'package:cinnamon_riverpod_2/features/account/controller/account_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/firebase_notifications/firebase_notifications_service.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:cinnamon_riverpod_2/infra/traveler/repository/traveler_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeNotifierProvider<AccountController, AccountState>
    accountControllerProvider =
    NotifierProvider.autoDispose<AccountController, AccountState>(
  () => AccountController(),
);

class AccountController extends AutoDisposeNotifier<AccountState> {
  FirebaseAuthService get _authService => ref.read(authServiceProvider);

  TravelerRepository get _travelerRepo => ref.read(travelerRepositoryProvider);

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  FirebaseNotificationsService get _fns =>
      ref.read(firebaseNotificationsService);

  Future<void> toggleNotifications(bool flag) async {
    if (flag) {
      if (!await _fns.askForPermissions()) {
        await AppSettings.openAppSettings(type: AppSettingsType.settings);
        if (!await _fns.askForPermissions()) {
          return;
        }
      }
    }
    await _travelerRepo.updateProfileData(<String, dynamic>{
      'sendPushNotifications': flag,
    });
    state = AccountState(notificationsFlag: flag);
  }

  Future<void> deleteUserAccount() async {
    state = const AccountState(loading: true);

    try {
      await _authService.deleteAccount().then((_) => _travelerRepo
          .deleteProfile()
          .then((_) => _tripRepo.removeUserTrips()));
    } catch (e) {
      state = const AccountState(loading: false);
      rethrow;
    }
    state = const AccountState(loading: false);
  }

  Future<bool> logOut() async {
    state = const AccountState(loading: true);

    await _authService.logout();

    state = const AccountState(loading: false);
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
