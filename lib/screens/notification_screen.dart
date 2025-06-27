import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Widget customBackButton(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'lib/assets/images/icon/back2.png',
        width: 24,  // Adjust size as needed
        height: 24,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        "message": "Welcome to Travel Assistant!",
        "time": "Just now",
      },
      {
        "message": "New destination added: Santorini, Greece!",
        "time": "2 hours ago",
      },
      {
        "message": "Don't forget to check your packing checklist.",
        "time": "Yesterday",
      },
      {
        "message": "You recently saved Bali to your favorites.",
        "time": "2 days ago",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: customBackButton(context),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification["message"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification["time"],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}