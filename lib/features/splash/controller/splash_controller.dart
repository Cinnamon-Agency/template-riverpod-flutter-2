import 'dart:async';

import 'package:cinnamon_riverpod_2/features/splash/controller/splash_state.dart';
import 'package:cinnamon_riverpod_2/infra/auth/service/firebase_auth_service.dart';
import 'package:cinnamon_riverpod_2/infra/http/http_service.dart';
import 'package:cinnamon_riverpod_2/infra/local_notifications/notification_service.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinnamon_riverpod_2/infra/purchases/purchases_service.dart';

final splashControllerProvider = AsyncNotifierProvider.autoDispose<SplashController, SplashState>(
  () => SplashController(),
);

class SplashController extends AutoDisposeAsyncNotifier<SplashState> {
  @override
  FutureOr<SplashState> build() async {
    final user = await ref.read(firebaseUserProvider.future);
    // warmup user id provider
    final userId = ref.read(userIdProvider);
    final http = ref.read(httpServiceProvider);
    final localStorageService = ref.read(localStorageServiceProvider);
    final purchases = ref.read(purchaseServiceProvider);
    final notifications = ref.read(notificationServiceProvider);

    await localStorageService.init();

    await http.init();
    // await purchases.init();
    //
    // await notifications.init();
    return SplashState(user.isAnonymous);
  }
}
