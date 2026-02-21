import 'package:flutter/material.dart';
import 'package:hairfidence/UpdateProfile.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:hairfidence/login.dart';
import 'RequestStatusPage.dart';

class ViewNgoPostsPage extends StatefulWidget {
  const ViewNgoPostsPage({super.key});

  @override
  State<ViewNgoPostsPage> createState() => _ViewNgoPostsPageState();
}

class _ViewNgoPostsPageState extends State<ViewNgoPostsPage> {


  bool loading = true;
  List ngoPosts = [];

  @override
  void initState() {
    super.initState();
    fetchNgoPost();
  }

  Future<void> fetchNgoPost() async {
    try {
      final res = await dio.get("$baseUrl/ngopost");

      setState(() {
        ngoPosts = res.data;
        loading = false;
      });
    } catch (e) {
      loading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to load NGO posts")));
    }
  }

  Future<void> sendRequest(String postId) async {
    try {
      await dio.post("$baseUrl/request/send-request", data: {
        "postId": postId,
        "profileId": proid,
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Request Sent")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Already Requested")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Available Hair Donations",
            style: TextStyle(color: Color(0xFFFFC107))),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Color(0xFFFFC107)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestStatusPage(profileId: proid),
                ),
              );
            },
          )
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
                        Text(
                          post["title"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 8),

                        _row("Hair Length", post["hairLength"].toString()),
                        _row("Hair Type", post["hairType"]),
                        _row("Hair Color", post["hairColor"]),
                        _row("Chemically Treated", post["chemicallyTreated"]),
                        _row("Grey Hair", post["greyHair"]),
                        _row("Quantity", post["quantity"].toString()),
                        _row("Condition", post["condition"]),
                        _row("Location", post["location"]),

                        const SizedBox(height: 8),

                        Text(
                          post["description"],
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC107),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => sendRequest(post["_id"]),
                            child: const Text(
                              "SEND REQUEST",
                              style: TextStyle(
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

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text("$label: ",
              style: const TextStyle(color: Colors.white70)),
          Expanded(
            child:
                Text(value, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
