import 'package:flutter/material.dart';

class DonorHairAppointmentPage extends StatefulWidget {
  const DonorHairAppointmentPage({super.key});

  @override
  State<DonorHairAppointmentPage> createState() =>
      _DonorHairAppointmentPageState();
}

class _DonorHairAppointmentPageState
    extends State<DonorHairAppointmentPage> {
  List<Map<String, String>> requests = [
    {"date": "19-04-2026", "status": "Pending"},
    {"date": "21-04-2026", "status": "Approved"},
    {"date": "18-04-2026", "status": "Rejected"},
  ];

  Color statusColor(String status) {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Hair Donation Requests",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];

          return Card(
            color: const Color(0xFF1C1C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Requested Date",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    request["date"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Text(
                        "Status: ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        request["status"]!,
                        style: TextStyle(
                          color: statusColor(request["status"]!),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  if (request["status"] == "Pending")
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                request["status"] = "Approved";
                              });
                            },
                            child: const Text("Approve"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                request["status"] = "Rejected";
                              });
                            },
                            child: const Text("Reject"),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
