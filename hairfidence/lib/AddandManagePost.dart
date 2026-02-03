import 'package:flutter/material.dart';

class NgoPostPage extends StatefulWidget {
  const NgoPostPage({super.key});

  @override
  State<NgoPostPage> createState() => _NgoPostPageState();
}

class _NgoPostPageState extends State<NgoPostPage> {
  final TextEditingController dateController = TextEditingController();

  List<String> posts = [
    "18-04-2026",
    "20-04-2026",
  ];

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setState(() {});
    }
  }

  void addPost() {
    if (dateController.text.isEmpty) return;

    setState(() {
      posts.add(dateController.text);
      dateController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post added successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Add & Manage Posts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ADD POST CARD
            Card(
              color: const Color(0xFF1C1C1C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.post_add,
                        size: 50, color: Color(0xFFFFC107)),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Post Date",
                        labelStyle:
                            const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xFFFFC107),
                        ),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: selectDate,
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFC107),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: addPost,
                        child: const Text(
                          "ADD POST",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// MANAGE POSTS
            Expanded(
              child: posts.isEmpty
                  ? const Center(
                      child: Text(
                        "No posts available",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: const Color(0xFF1C1C1C),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          margin:
                              const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(
                              Icons.calendar_month,
                              color: Color(0xFFFFC107),
                            ),
                            title: Text(
                              posts[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  posts.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
