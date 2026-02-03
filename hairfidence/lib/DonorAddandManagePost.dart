import 'package:flutter/material.dart';

class DonorAddManagePostPage extends StatefulWidget {
  const DonorAddManagePostPage({super.key});

  @override
  State<DonorAddManagePostPage> createState() => _DonorAddManagePostPageState();
}

class _DonorAddManagePostPageState extends State<DonorAddManagePostPage> {
  final TextEditingController dateController = TextEditingController();

  List<Map<String, String>> donorPosts = [
    {
      "date": "19-04-2026",
      "status": "Pending",
      "note": "Waiting for NGO approval"
    },
    {
      "date": "12-03-2026",
      "status": "Rejected",
      "note": "Hair length not sufficient"
    },
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
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      setState(() {});
    }
  }

  Color statusColor(String status) {
    if (status == "Approved") return Colors.green;
    if (status == "Rejected") return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Donor - Add & Manage Post",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Donor Info Card
            Card(
              color: const Color(0xFF1C1C1C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.person,
                    color: Color(0xFFFFC107), size: 40),
                title: const Text(
                  "Donor Name: Alex",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  "Hair Donation Volunteer",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Add Post Section
            Card(
              color: const Color(0xFF1C1C1C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Donation Date",
                        labelStyle:
                            const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xFFFFC107)),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: selectDate,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFC107),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          if (dateController.text.isNotEmpty) {
                            setState(() {
                              donorPosts.add({
                                "date": dateController.text,
                                "status": "Pending",
                                "note": "Awaiting NGO response"
                              });
                              dateController.clear();
                            });
                          }
                        },
                        child: const Text(
                          "ADD POST",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Manage Posts
            Expanded(
              child: ListView.builder(
                itemCount: donorPosts.length,
                itemBuilder: (context, index) {
                  final post = donorPosts[index];

                  return Card(
                    color: const Color(0xFF1C1C1C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: ListTile(
                      leading: const Icon(Icons.volunteer_activism,
                          color: Color(0xFFFFC107)),
                      title: Text(
                        "Donation Date: ${post["date"]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            "Status: ${post["status"]}",
                            style: TextStyle(
                              color: statusColor(post["status"]!),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Note: ${post["note"]}",
                            style:
                                const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: post["status"] == "Pending"
                          ? IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  donorPosts.removeAt(index);
                                });
                              },
                            )
                          : null,
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
