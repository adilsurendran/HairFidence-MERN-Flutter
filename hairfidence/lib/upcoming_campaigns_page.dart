import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:intl/intl.dart';


class UpcomingCampaignsPage extends StatefulWidget {
  const UpcomingCampaignsPage({super.key});

  @override
  State<UpcomingCampaignsPage> createState() =>
      _UpcomingCampaignsPageState();
}

class _UpcomingCampaignsPageState extends State<UpcomingCampaignsPage> {
  final Dio dio = Dio();

  List campaigns = [];
  bool loading = true;

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

  @override
  void initState() {
    super.initState();
    fetchUpcomingCampaigns();
  }

  /* ===============================
     FETCH UPCOMING CAMPAIGNS
  =============================== */
  Future<void> fetchUpcomingCampaigns() async {
    final today = DateFormat("yyyy-MM-dd").format(DateTime.now());

    try {
      final res =
          await dio.get("$baseUrl/campaigns/upcoming/$today");

      setState(() {
        campaigns = res.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load campaigns")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,

      /* ===============================
         APP BAR
      =============================== */
      appBar: AppBar(
        title: const Text(
          "Upcoming Campaigns",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: gold,
        centerTitle: true,
      ),

      /* ===============================
         BODY
      =============================== */
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : campaigns.isEmpty
              ? const Center(
                  child: Text(
                    "No upcoming campaigns",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final c = campaigns[index];
                    final ngo = c["ngoId"];

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            /// CAMPAIGN NAME
                            Text(
                              c["name"],
                              style: TextStyle(
                                color: gold,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            _infoRow("Date", c["date"]),
                            _infoRow("Time", c["time"]),
                            _infoRow("Location", c["location"]),

                            const Divider(color: Colors.grey),

                            /// NGO DETAILS
                            Text(
                              "NGO Details",
                              style: TextStyle(
                                color: gold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            _infoRow("Name", ngo["name"]),
                            _infoRow(
                                "Place",
                                "${ngo["place"]}, ${ngo["pincode"]}"),
                            _infoRow("Phone", ngo["phone"] ?? "N/A"),
                            _infoRow("Email", ngo["email"] ?? "N/A"),

                            if (c["description"] != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8),
                                child: Text(
                                  c["description"],
                                  style: const TextStyle(
                                      color: Colors.white70),
                                ),
                              ),

                            /// IMAGE
                            if (c["image"] != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  child: Image.network(
                                    "$baseUrl/uploads/${c["image"]}",
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
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
     INFO ROW
  =============================== */
  Widget _infoRow(String label, String value) {
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
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
