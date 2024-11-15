import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/notification_service.dart';
import 'viewmodels/notification_viewmodel.dart';
import 'views/notification_screen.dart';

// The main function is the entry point of the application
void main() async {
  // Ensures that Flutter is fully initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initializes Firebase
  await Firebase.initializeApp();
  // Gets an instance of Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Initialize the notification service
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  // Get and print the FCM token
  String? token = await messaging.getToken();

  if (kDebugMode) {
    // Prints the FCM token in debug mode
    print('FCM Token: $token');
  }

  // Runs the application
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Provides NotificationViewModel to the widget tree
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
