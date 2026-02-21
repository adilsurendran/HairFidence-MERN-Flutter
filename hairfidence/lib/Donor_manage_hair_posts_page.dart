
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'donor_add_hair_post_page.dart';

class DonorManageHairPostsPage extends StatefulWidget {
  const DonorManageHairPostsPage({super.key});

  @override
  State<DonorManageHairPostsPage> createState() =>
      _DonorManageHairPostsPageState();
}

class _DonorManageHairPostsPageState
    extends State<DonorManageHairPostsPage> {
  final Dio dio = Dio();

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

  List posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  /* ===============================
     FETCH POSTS
  =============================== */
  Future<void> fetchPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString("profileId");

    final res = await dio.get("$baseUrl/donor-hair-posts/$donorId");

    setState(() {
      posts = res.data;
      loading = false;
    });
  }

  /* ===============================
     DELETE POST (ONLY PENDING)
  =============================== */
  Future<void> deletePost(String id) async {
    if (!await _confirm()) return;
    await dio.delete("$baseUrl/donor-hair-posts/$id");
    fetchPosts();
  }

  Future<bool> _confirm() async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF1C1C1C),
            title: const Text("Delete Post",
                style: TextStyle(color: Colors.white)),
            content: const Text(
              "Are you sure you want to delete this post?",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel",
                    style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  /* ===============================
     STATUS COLOR
  =============================== */
  Color statusColor(String status) {
    switch (status) {
      case "pending":
        return gold;
      case "approved":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "collected":
        return Colors.blueGrey;
      default:
        return Colors.grey;
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
        backgroundColor: dark,
        title: const Text(
          "My Donation Posts",
          style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFFFC107)),
            onPressed: () async {
              final refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DonorAddHairPostPage(),
                ),
              );
              if (refresh == true) fetchPosts();
            },
          ),
        ],
      ),

      /* ===============================
         BODY
      =============================== */
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? const Center(
                  child: Text(
                    "No donation posts yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, i) {
                    final p = posts[i];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(18),
                        border:
                            Border.all(color: gold.withOpacity(0.35)),
                        boxShadow: [
                          BoxShadow(
                            color: gold.withOpacity(0.15),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* TITLE */
                          Text(
                            p["title"],
                            style: TextStyle(
                              color: gold,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          /* DETAILS */
                          Text(
                            "Hair: ${p["hairType"]} | ${p["hairLength"]} cm",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Color: ${p["hairColor"]}",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Condition: ${p["condition"]}",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Donation Date: ${p["donationDate"]}",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Location: ${p["location"]}",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 10),

                          /* STATUS */
                          Row(
                            children: [
                              const Text(
                                "Status: ",
                                style:
                                    TextStyle(color: Colors.white70),
                              ),
                              Text(
                                p["status"].toUpperCase(),
                                style: TextStyle(
                                  color: statusColor(p["status"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          /* REJECT NOTE */
                          if (p["status"] == "rejected" &&
                              p["rejectNote"] != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              "Reject Reason:",
                              style: TextStyle(
                                  color: Colors.red.shade300,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              p["rejectNote"],
                              style: const TextStyle(
                                  color: Colors.white70),
                            ),
                          ],

                          const SizedBox(height: 12),

                          /* DELETE ONLY IF PENDING */
                          if (p["status"] == "pending")
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () => deletePost(p["_id"]),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
