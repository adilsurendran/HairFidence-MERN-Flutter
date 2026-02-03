import 'package:flutter/material.dart';

class ViewNotificationsPage extends StatelessWidget {
  const ViewNotificationsPage({super.key});

  // Sample notification data
  final List<Map<String, String>> notifications = const [
   
    {
      "title": "Report Uploaded",
      "message": "your medical  certificate is availabe.",
      "date": "15-01-2026"
    },
   
    {
      "title": "Reminder",
      "message": "Please update your profile before your next appointment.",
      "date": "12-01-2026"
    },
     {
      "title": "HAIRFIDENCE",
      "message": "Your courage inspires everyone around you; don't give up!.",
      "date": "12-01-2026"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  color: const Color(0xFF1C1C1C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 6,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const Icon(
                      Icons.notifications,
                      color: Color(0xFFFFC107),
                      size: 35,
                    ),
                    title: Text(
                      notification["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification["message"]!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            notification["date"]!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
