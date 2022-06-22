import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:p11/main.dart';

class Firebasenoti extends StatefulWidget {
  const Firebasenoti({Key? key}) : super(key: key);

  @override
  State<Firebasenoti> createState() => _FirebasenotiState();
}

class _FirebasenotiState extends State<Firebasenoti> {
  @override
  void initState() {
    super.initState();

    AndroidInitializationSettings andint =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iosint = IOSInitializationSettings();

    InitializationSettings initializationSettings =
        InitializationSettings(android: andint, iOS: iosint);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? remoteNotification = event.notification;
      AndroidNotification? androidNotification = event.notification!.android;

      if (remoteNotification != null || androidNotification != null) {
        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.max, priority: Priority.high);
        flutterLocalNotificationsPlugin.show(
            remoteNotification.hashCode,
            remoteNotification!.title,
            remoteNotification.body,
            NotificationDetails(android: androidNotificationDetails));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
