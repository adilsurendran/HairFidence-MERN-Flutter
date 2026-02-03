import 'package:flutter/material.dart';

class AppointmentStatusPage extends StatelessWidget {
  const AppointmentStatusPage({super.key});

  // Sample status from NGO
  final String appointmentStatus = "Approved"; // Pending / Rejected

  Color getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Approved":
        return Icons.check_circle;
      case "Pending":
        return Icons.hourglass_top;
      case "Rejected":
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Post Status",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(16),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  getStatusIcon(appointmentStatus),
                  color: getStatusColor(appointmentStatus),
                  size: 80,
                ),
                const SizedBox(height: 20),
                Text(
                  "Your Post is",
                  style: TextStyle(color: Colors.grey[400], fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  appointmentStatus,
                  style: TextStyle(
                      color: getStatusColor(appointmentStatus),
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  "This is confirmed by the NGO",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
