import 'package:flutter/material.dart';

class ViewNgoPostsPage extends StatefulWidget {
  const ViewNgoPostsPage({super.key});

  @override
  State<ViewNgoPostsPage> createState() => _ViewNgoPostsPageState();
}

class _ViewNgoPostsPageState extends State<ViewNgoPostsPage> {
  List<Map<String, dynamic>> ngoPosts = [
    {"date": "18-04-2026", "requested": false},
    {"date": "20-04-2026", "requested": false},
    {"date": "22-04-2026", "requested": true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Available Hair Donation Dates",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: ngoPosts.length,
        itemBuilder: (context, index) {
          final post = ngoPosts[index];

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
                  const Text(
                    "Hair Donation Date",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    post["date"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: post["requested"]
                            ? Colors.grey
                            : const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: post["requested"]
                          ? null
                          : () {
                              setState(() {
                                post["requested"] = true;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Request sent for ${post["date"]}"),
                                ),
                              );
                            },
                      child: Text(
                        post["requested"]
                            ? "REQUEST SENT"
                            : "SEND REQUEST",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
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
