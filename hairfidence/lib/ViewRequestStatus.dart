import 'package:flutter/material.dart';

class ViewRequestStatusPage extends StatelessWidget {
  const ViewRequestStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> requestStatusList = [
      {"date": "18-04-2026", "status": "Pending"},
      {"date": "20-04-2026", "status": "Approved"},
      {"date": "22-04-2026", "status": "Rejected"},
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case "Approved":
          return Colors.green;
        case "Rejected":
          return Colors.red;
        default:
          return Colors.orange;
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Request Status",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: requestStatusList.length,
        itemBuilder: (context, index) {
          final item = requestStatusList[index];

          return Card(
            color: const Color(0xFF1C1C1C),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hair Donation Date",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item["date"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusColor(item["status"]!).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item["status"]!,
                      style: TextStyle(
                        color: getStatusColor(item["status"]!),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
