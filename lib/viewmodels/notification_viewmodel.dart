import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';

// This class handles notifications and updates the UI
class NotificationViewModel extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Getter to access the list of notifications
  List<NotificationModel> get notifications => _notifications;

  // Constructor to initialize Firebase when an instance is created
  NotificationViewModel() {
    _initializeFirebase();
  }

  // Method to initialize Firebase and set up listeners for notification messages
  void _initializeFirebase() {
    // Listen to messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    // Handle messages when the app is opened via a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    // Handle when the app is launched from a terminated state via a notification
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }

  // Method to handle incoming messages and add them to the list of notifications
  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      final notification = NotificationModel(
        title: message.notification!.title ??
            'No Title', // Default title if not provided
        body: message.notification!.body ??
            'No Body', // Default body if not provided
      );

      // Check for duplicates before adding the notification to the list
      if (!_notifications.any((n) =>
          n.title == notification.title && n.body == notification.body)) {
        _notifications.add(notification);
        notifyListeners();
      }
    }
  }
}
