import 'package:flutter/material.dart';

class DonorDonationHistoryPage extends StatelessWidget {
  const DonorDonationHistoryPage({super.key});

  Color statusColor(String status) {
    if (status == "Approved") return Colors.green;
    if (status == "Rejected") return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    // Dummy donation history data
    final List<Map<String, String>> donationHistory = [
      {
        "date": "10-01-2026",
        "status": "Approved",
        "note": "Hair collected successfully"
      },
      {
        "date": "19-04-2026",
        "status": "Pending",
        "note": "Waiting for NGO confirmation"
      },
      {
        "date": "12-03-2026",
        "status": "Rejected",
        "note": "Hair length insufficient"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Donation History & Status",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: donationHistory.isEmpty
            ? const Center(
                child: Text(
                  "No donation history available",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: donationHistory.length,
                itemBuilder: (context, index) {
                  final history = donationHistory[index];

                  return Card(
                    color: const Color(0xFF1C1C1C),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.volunteer_activism,
                        color: Color(0xFFFFC107),
                        size: 36,
                      ),
                      title: Text(
                        "Donation Date: ${history["date"]}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status: ${history["status"]}",
                              style: TextStyle(
                                color: statusColor(history["status"]!),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Note: ${history["note"]}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      trailing: Icon(
                        history["status"] == "Approved"
                            ? Icons.check_circle
                            : history["status"] == "Rejected"
                                ? Icons.cancel
                                : Icons.hourglass_top,
                        color: statusColor(history["status"]!),
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
