import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeProvider<FirebaseNotificationsService>
    firebaseNotificationsService =
    AutoDisposeProvider<FirebaseNotificationsService>(
        (AutoDisposeProviderRef<FirebaseNotificationsService> ref) =>
            FirebaseNotificationsService());

class FirebaseNotificationsService {
  /// Notification permission prompt
  Future<bool> askForPermissions() async {
    NotificationSettings notificationSettings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized;
  }
}
