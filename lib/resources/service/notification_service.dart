import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging;

  NotificationService(this._firebaseMessaging);
  void initializeMessages() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  void configure() {
    Future.delayed(Duration(seconds: 2), () {
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("NOTIFICATION $message");
        },
        onBackgroundMessage: (Map<String, dynamic> message) async {},
        onLaunch: (Map<String, dynamic> message) async {},
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
    });
  }

  Future<String> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    return token;
  }

  String getDeviceType() {
    return Platform.isAndroid ? "android" : "ios";
  }
}
