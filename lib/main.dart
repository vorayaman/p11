import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:p11/auth/fireclass.dart';
import 'package:p11/auth/home.dart';
import 'package:p11/auth/localnotification.dart';
import 'package:p11/auth/splesh.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}


AndroidNotificationChannel channel = AndroidNotificationChannel(
    "1", "Testing", importance: Importance.max);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
      channel);

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/notificationlocal',
      routes: {
        '/': (context) => Myapp(),
        '/home': (context) => HOMESCREEN(),
        '/splesh': (context) => Splesh(),
        '/notificationlocal': (context) => Notificationlocal(),
      },
    ),
  );
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    Auth a1 = Auth();
    a1.currentUser(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: txt_email,
                decoration: InputDecoration(hintText: "EMAIL"),
              ),
              TextField(
                controller: txt_password,
                decoration: InputDecoration(hintText: "PASSWORD"),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.Singup(txt_email.text, txt_password.text);
                },
                child: Text("Sign Up"),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.Singin(txt_email.text, txt_password.text, context);
                },
                child: Text("Sign In"),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.googleSingIn(context);
                },
                child: Text("Goggle"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
