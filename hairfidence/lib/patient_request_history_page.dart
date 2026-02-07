import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/UpdateProfile.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PatientRequestHistoryPage extends StatefulWidget {
  const PatientRequestHistoryPage({super.key});

  @override
  State<PatientRequestHistoryPage> createState() =>
      _PatientRequestHistoryPageState();
}

class _PatientRequestHistoryPageState
    extends State<PatientRequestHistoryPage> {

  List requests = [];
  bool loading = true;

  final Color gold = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  /* ===============================
     FETCH REQUESTS
  =============================== */
  Future<void> fetchRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final patientId = prefs.getString("profileId");

    final res =
        await dio.get("$baseUrl/patient-post-requests/patient/$patientId");

    setState(() {
      requests = res.data;
      loading = false;
    });
  }

  /* ===============================
     UPDATE STATUS
  =============================== */
  Future<void> updateStatus(String requestId, String status) async {
    await dio.put(
      "$baseUrl/patient-post-requests/$requestId/status",
      data: {"status": status},
    );

    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "NGO Requests",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: gold,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
              ? const Center(
                  child: Text(
                    "No requests received",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: requests.length,
                  itemBuilder: (context, i) {
                    final r = requests[i];
                    final ngo = r["ngoId"];
                    final post = r["postId"];

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// NGO INFO
                            Text(
                              ngo["name"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${ngo["place"]} - ${ngo["pincode"]}",
                              style: const TextStyle(color: Colors.white70),
                            ),

                            const Divider(color: Colors.grey),

                            /// POST DETAILS
                            _row("Hair", "${post["hairType"]}"),
                            _row("Length", "${post["hairLength"]} cm"),
                            _row("Color", post["hairColor"]),
                            _row("Quantity", "${post["quantity"]} g"),
                            _row("Location", post["location"]),

                            const SizedBox(height: 10),

                            /// MESSAGE
                            Text(
                              "Message:",
                              style: TextStyle(
                                  color: gold,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              r["message"] ?? "-",
                              style:
                                  const TextStyle(color: Colors.white70),
                            ),

                            const SizedBox(height: 12),

                            /// STATUS / ACTIONS
                            if (r["status"] == "pending")
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () => updateStatus(
                                          r["_id"], "approved"),
                                      child: const Text("ACCEPT"),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () => updateStatus(
                                          r["_id"], "rejected"),
                                      child: const Text("REJECT"),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Text(
                                "Status: ${r["status"].toUpperCase()}",
                                style: TextStyle(
                                  color: r["status"] == "approved"
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
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

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
