import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<NotificationModel> get notifications => _notifications;

  NotificationViewModel() {
    _initializeFirebase();
  }

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

  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      final notification = NotificationModel(
        title: message.notification!.title ?? 'No Title',
        body: message.notification!.body ?? 'No Body',
      );

      // Check for duplicates before adding
      if (!_notifications.any((n) =>
          n.title == notification.title && n.body == notification.body)) {
        _notifications.add(notification);
        notifyListeners();
      }
    }
  }
}
