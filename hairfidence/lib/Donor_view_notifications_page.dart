import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorViewNotificationsPage extends StatefulWidget {
  const DonorViewNotificationsPage({super.key});

  @override
  State<DonorViewNotificationsPage> createState() =>
      _DonorViewNotificationsPageState();
}

class _DonorViewNotificationsPageState
    extends State<DonorViewNotificationsPage> {
  final Dio dio = Dio();

  List notifications = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  /* ===============================
     FETCH DONOR NOTIFICATIONS
  =============================== */
  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString("profileId");

    try {
      final res = await dio.get(
        "$baseUrl/notifications/donor/$donorId",
      );

      setState(() {
        notifications = res.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load notifications")),
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
          "Notifications",
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      /* ===============================
         BODY
      =============================== */
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(
                  child: Text(
                    "No notifications yet",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 6,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: const Icon(
                          Icons.notifications,
                          color: Color(0xFFFFC107),
                          size: 35,
                        ),
                        title: Text(
                          n["title"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                n["message"],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _formatDate(n["createdAt"]),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
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
