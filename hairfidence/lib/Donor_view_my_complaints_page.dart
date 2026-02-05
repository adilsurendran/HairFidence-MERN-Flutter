import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DonorRegister.dart';

class DonorViewMyComplaintsPage extends StatefulWidget {
  const DonorViewMyComplaintsPage({super.key});

  @override
  State<DonorViewMyComplaintsPage> createState() =>
      _DonorViewMyComplaintsPageState();
}

class _DonorViewMyComplaintsPageState
    extends State<DonorViewMyComplaintsPage> {
  final Dio dio = Dio();
  final Color gold = const Color(0xFFFFC107);

  List complaints = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString("profileId");

    try {
      final res =
          await dio.get("$baseUrl/complaints/user/$donorId");

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
      appBar: AppBar(
        title: const Text("My Complaints",
            style: TextStyle(color: Colors.black)),
        backgroundColor: gold,
        centerTitle: true,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : complaints.isEmpty
              ? const Center(
                  child: Text("No complaints submitted",
                      style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: complaints.length,
                  itemBuilder: (context, i) {
                    final c = complaints[i];

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              c["subject"],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              c["message"],
                              style: const TextStyle(
                                  color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (c["reply"] != null) ...[
                              const SizedBox(height: 14),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                      color:
                                          gold.withOpacity(0.4)),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text("Admin Reply",
                                        style: TextStyle(
                                            color: gold,
                                            fontWeight:
                                                FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    Text(c["reply"],
                                        style: const TextStyle(
                                            color:
                                                Colors.white70)),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
