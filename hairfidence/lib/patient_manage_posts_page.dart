// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hairfidence/DonorRegister.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'patient_add_post_page.dart';
// import 'patient_request_history_page.dart';

// class PatientManagePostsPage extends StatefulWidget {
//   const PatientManagePostsPage({super.key});

//   @override
//   State<PatientManagePostsPage> createState() =>
//       _PatientManagePostsPageState();
// }

// class _PatientManagePostsPageState extends State<PatientManagePostsPage> {
//   final Dio dio = Dio();
//   List posts = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchPosts();
//   }

//   Future<void> fetchPosts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final patientId = prefs.getString("profileId");

//     final res =
//         await dio.get("$baseUrl/patient-posts/$patientId");
//         print(res.data);

//     setState(() {
//       posts = res.data;
//       loading = false;
//     });
//   }

//   Future<void> deletePost(String id) async {
//     await dio.delete("$baseUrl/patient-posts/$id");
//     fetchPosts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title:
//             const Text("My Hair Posts", style: TextStyle(color: Colors.black)),
//         backgroundColor: const Color(0xFFFFC107),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.history, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) =>
//                         const PatientRequestHistoryPage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.black),
//             onPressed: () async {
//               final refresh = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => const PatientAddPostPage()),
//               );
//               if (refresh == true) fetchPosts();
//             },
//           ),
//         ],
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : posts.isEmpty
//               ? const Center(
//                   child: Text("No posts",
//                       style: TextStyle(color: Colors.white70)))
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: posts.length,
//                   itemBuilder: (context, i) {
//                     final p = posts[i];
//                     return Card(
//                       color: const Color(0xFF1C1C1C),
//                       margin: const EdgeInsets.only(bottom: 12),
//                       child: ListTile(
//                         title: Text(
//                           "${p["hairType"]} | ${p["hairLength"]} cm",
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         subtitle: Text(
//                           p["location"],
//                           style:
//                               const TextStyle(color: Colors.white70),
//                         ),
//                         trailing: IconButton(
//                           icon:
//                               const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => deletePost(p["_id"]),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'patient_add_post_page.dart';
import 'patient_request_history_page.dart';

// 🔴 CHANGE BASE URL IF NEEDED

class PatientManagePostsPage extends StatefulWidget {
  const PatientManagePostsPage({super.key});

  @override
  State<PatientManagePostsPage> createState() =>
      _PatientManagePostsPageState();
}

class _PatientManagePostsPageState extends State<PatientManagePostsPage> {
  final Dio dio = Dio();

  List posts = [];
  bool loading = true;

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

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
    final patientId = prefs.getString("profileId");

    try {
      final res =
          await dio.get("$baseUrl/patient-posts/$patientId");

      setState(() {
        posts = res.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load posts")),
      );
    }
  }

  /* ===============================
     DELETE POST (ONLY ACTIVE)
  =============================== */
  Future<void> deletePost(String id) async {
    final confirm = await showDialog<bool>(
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
            child:
                const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete",
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await dio.delete("$baseUrl/patient-posts/$id");
    fetchPosts();
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
          "My Hair Posts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: gold,
        centerTitle: true,
        actions: [
          /// REQUEST HISTORY
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PatientRequestHistoryPage(),
                ),
              );
            },
          ),

          /// ADD POST
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final refresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PatientAddPostPage(),
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
                    "No posts available",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: posts.length,
                  itemBuilder: (context, i) {
                    final p = posts[i];
                    final bool isClosed = p["status"] == "closed";

                    return Card(
                      color: const Color(0xFF1C1C1C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// HEADER
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${p["hairType"]} Hair • ${p["hairLength"]} cm",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                /// STATUS BADGE
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isClosed
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    p["status"].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            _infoRow("Hair Color", p["hairColor"]),
                            _infoRow(
                                "Quantity", "${p["quantity"]} g"),
                            _infoRow("Location", p["location"]),
                            _infoRow(
                              "Description",
                              p["description"]?.isNotEmpty == true
                                  ? p["description"]
                                  : "N/A",
                            ),

                            const SizedBox(height: 12),

                            /// DELETE (ONLY IF ACTIVE)
                            if (!isClosed)
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      deletePost(p["_id"]),
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
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
