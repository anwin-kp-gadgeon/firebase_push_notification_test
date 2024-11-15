import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/notification_service.dart';
import 'viewmodels/notification_viewmodel.dart';
import 'views/notification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Initialize the notification service
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  // Get and print the FCM token
  String? token = await messaging.getToken();
  // if (kDebugMode) {
    // ignore: avoid_print
    print('FCM Token: $token');
  // }

  await analytics.logEvent(
    name: 'app_start',
    parameters: <String, Object>{
      'string': 'hello' as Object,
      'int': 123 as Object,
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Push Notifications',
        home: NotificationScreen(),
      ),
    );
  }
}
