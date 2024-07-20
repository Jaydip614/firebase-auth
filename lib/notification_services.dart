import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices{
  static Future<void> initialize() async {
    NotificationSettings notificationSettings = await FirebaseMessaging.instance.requestPermission();
    if(notificationSettings.authorizationStatus == AuthorizationStatus.authorized){
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);
      FirebaseMessaging.onMessage.listen((message) {
        log("${message.notification!.title}");
      },
      );
      log("Notification authorized successfully");
    }
  }
}

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  log("${remoteMessage.notification!.title}");
}