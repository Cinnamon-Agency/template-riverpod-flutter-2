import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeProvider<FirebaseNotificationsService>
    firebaseNotificationsService =
    AutoDisposeProvider<FirebaseNotificationsService>(
        (AutoDisposeProviderRef<FirebaseNotificationsService> ref) =>
            FirebaseNotificationsService());

class FirebaseNotificationsService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Notification permission prompt
  Future<bool> askForPermissions() async {
    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // TODO(Anyone): Do something with FCM token
    log('User FCM token: ${await getFCMToken()}');

    return notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized;
  }

  Future<String?> getFCMToken() => _firebaseMessaging.getToken();
}
