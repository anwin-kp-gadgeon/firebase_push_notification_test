import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/notification_viewmodel.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
        centerTitle: true,
        backgroundColor: Colors.teal, // App bar color
        elevation: 4,
      ),
      body: Container(
        color: Colors.white, // Solid background color
        child: Consumer<NotificationViewModel>(
          builder: (context, viewModel, child) {
            final notifications = viewModel.notifications;
            if (notifications.isEmpty) {
              return const Center(
                  child: Text('No notifications available',
                      style: TextStyle(fontSize: 18, color: Colors.black)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation:
                      6, // Increased shadow effect for a more vibrant look
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius:
                                BorderRadius.circular(25.0), // Circular avatar
                          ),
                          child: const Icon(Icons.notifications,
                              color: Colors.white), // Notification icon
                        ),
                        const SizedBox(
                            width: 16.0), // Space between icon and text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notifications[index].title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Title color
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                notifications[index].body,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey, // Subtitle color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
