import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notificationlocal extends StatefulWidget {
  const Notificationlocal({Key? key}) : super(key: key);

  @override
  State<Notificationlocal> createState() => _NotificationlocalState();
}

class _NotificationlocalState extends State<Notificationlocal> {
  FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    AndroidInitializationSettings Aint =
        AndroidInitializationSettings('app_icon');
    IOSInitializationSettings Iint = IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: Aint,
      iOS: Iint,
    );

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: Selectenoti);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    shownotification();
                  },
                  child: Text("local"),
                ),
                ElevatedButton(
                  onPressed: () {
                    shedaleNotification();
                  },
                  child: Text("Schedule"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Selectenoti(String? payload) {}

  void shownotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Title",
        priority: Priority.high, importance: Importance.max);
    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.show(
        1, "ADD NEWS", "TESTING", NotificationDetails(iOS: ios, android: and));
  }

  void shedaleNotification() {
    AndroidNotificationDetails and = AndroidNotificationDetails("1", "Schedual",
        importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails ios = IOSNotificationDetails();

    _notificationsPlugin.zonedSchedule(
        1,
        "2 second",
        "testing",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        NotificationDetails(android: and, iOS: ios),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
