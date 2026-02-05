import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ViewMyComplaintsPage extends StatefulWidget {
  const ViewMyComplaintsPage({super.key});

  @override
  State<ViewMyComplaintsPage> createState() =>
      _ViewMyComplaintsPageState();
}

class _ViewMyComplaintsPageState extends State<ViewMyComplaintsPage> {
  final Dio dio = Dio();

  List complaints = [];
  bool loading = true;

  final Color gold = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  /* ===============================
     FETCH USER COMPLAINTS
  =============================== */
  Future<void> fetchComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final senderId = prefs.getString("profileId");

    try {
      final res =
          await dio.get("$baseUrl/complaints/user/$senderId");

      setState(() {
        complaints = res.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load complaints")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /* ===============================
         APP BAR
      =============================== */
      appBar: AppBar(
        title: const Text(
          "My Complaints",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: gold,
        centerTitle: true,
      ),

      /* ===============================
         BODY
      =============================== */
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : complaints.isEmpty
              ? const Center(
                  child: Text(
                    "No complaints submitted",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: complaints.length,
                  itemBuilder: (context, index) {
                    final c = complaints[index];

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            /// SUBJECT
                            Text(
                              c["subject"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// MESSAGE
                            Text(
                              c["message"],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 12),

                            /// STATUS
                            Row(
                              children: [
                                Icon(
                                  c["status"] == "replied"
                                      ? Icons.check_circle
                                      : Icons.hourglass_bottom,
                                  color: c["status"] == "replied"
                                      ? Colors.green
                                      : Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  c["status"].toUpperCase(),
                                  style: TextStyle(
                                    color: c["status"] == "replied"
                                        ? Colors.green
                                        : Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            /// ADMIN REPLY
                            if (c["reply"] != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                      color: gold.withOpacity(0.4)),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.admin_panel_settings,
                                            color: gold, size: 18),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Admin Reply",
                                          style: TextStyle(
                                            color: gold,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      c["reply"],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: 10),

                            /// DATE
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                _formatDate(c["createdAt"]),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
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

  /* ===============================
     DATE FORMAT
  =============================== */
  String _formatDate(String date) {
    final d = DateTime.parse(date);
    return "${d.day}-${d.month}-${d.year}";
  }
}
