import 'package:flutter/material.dart';

class DonorViewNotificationsPage extends StatelessWidget {
  const DonorViewNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            title: "Appointment Approved",
            message:
                "Your hair donation appointment on 19/04/2026 has been approved by the NGO.",
            date: "19 Apr 2026",
            isRead: false,
          ),
          NotificationCard(
            title: "Request Rejected",
            message:
                "Your donation request dated 10/03/2026 has been rejected due to unavailability.",
            date: "10 Mar 2026",
            isRead: true,
          ),
          NotificationCard(
            title: "New NGO Post",
            message:
                "A new hair availability post has been added by Hope NGO.",
            date: "05 Mar 2026",
            isRead: true,
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String date;
  final bool isRead;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isRead ? const Color(0xFF1C1C1C) : const Color(0xFF2A2A2A),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: Icon(
          isRead ? Icons.notifications_none : Icons.notifications_active,
          color: const Color(0xFFFFC107),
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            message,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        trailing: Text(
          date,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
