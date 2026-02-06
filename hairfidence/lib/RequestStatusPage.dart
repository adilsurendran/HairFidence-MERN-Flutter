// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hairfidence/DonorRegister.dart';
// import 'package:hairfidence/UpdateProfile.dart';

// class RequestStatusPage extends StatefulWidget {
//   final String? profileId;

//   const RequestStatusPage({super.key, required this.profileId});

//   @override
//   State<RequestStatusPage> createState() => _RequestStatusPageState();
// }

// class _RequestStatusPageState extends State<RequestStatusPage> {


//   List requests = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchRequests();
//   }

//   Future<void> fetchRequests() async {
//     final res =
//         await dio.get("$baseUrl/request/my-requests/${widget.profileId}");
//         print(res.data);

//     setState(() {
//       requests = res.data;
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("My Requests",
//             style: TextStyle(color: Color(0xFFFFC107))),
//         backgroundColor: Colors.black,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: requests.length,
//               itemBuilder: (context, i) {
//                 final r = requests[i];

//                 return Card(
//                   color: const Color(0xFF1C1C1C),
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(r["postId"]["title"],
//                         style: const TextStyle(color: Colors.white)),
//                     subtitle: Text("Status: ${r["status"]}",
//                         style: const TextStyle(color: Colors.white70)),
//                   ),
//                 );
//               }),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hairfidence/DonorRegister.dart';
// import 'package:hairfidence/UpdateProfile.dart';

// class RequestStatusPage extends StatefulWidget {
//   final String? profileId;

//   const RequestStatusPage({super.key, required this.profileId});

//   @override
//   State<RequestStatusPage> createState() => _RequestStatusPageState();
// }

// class _RequestStatusPageState extends State<RequestStatusPage> {


//   List requests = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchRequests();
//   }

//   Future<void> fetchRequests() async {
//     final res =
//         await dio.get("$baseUrl/request/my-requests/${widget.profileId}");

//     setState(() {
//       requests = res.data;
//       loading = false;
//     });
//   }

//   Future<void> cancelRequest(String requestId) async {
//     await dio.put("$baseUrl/request/cancel/$requestId");

//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Request Cancelled")));

//     fetchRequests(); // refresh list
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("My Requests",
//             style: TextStyle(color: Color(0xFFFFC107))),
//         backgroundColor: Colors.black,
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: requests.length,
//               itemBuilder: (context, i) {
//                 final r = requests[i];
//                 final post = r["postId"];

//                 return Card(
//                   color: const Color(0xFF1C1C1C),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(post["title"],
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold)),

//                         const SizedBox(height: 6),

//                         Text(
//                           "Status: ${r["status"]}",
//                           style: TextStyle(
//                             color: r["status"] == "pending"
//                                 ? Colors.orange
//                                 : r["status"] == "approved"
//                                     ? Colors.green
//                                     : Colors.red,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         _row("Hair Length", post["hairLength"].toString()),
//                         _row("Hair Type", post["hairType"]),
//                         _row("Hair Color", post["hairColor"]),
//                         _row("Chemically Treated",
//                             post["chemicallyTreated"]),
//                         _row("Grey Hair", post["greyHair"]),
//                         _row("Quantity", post["quantity"].toString()),
//                         _row("Condition", post["condition"]),
//                         _row("Location", post["location"]),

//                         const SizedBox(height: 6),

//                         Text(post["description"],
//                             style:
//                                 const TextStyle(color: Colors.white70)),

//                         const SizedBox(height: 12),

//                         if (r["status"] == "pending")
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red),
//                               onPressed: () => cancelRequest(r["_id"]),
//                               child: const Text("CANCEL REQUEST",
//                                   style:
//                                       TextStyle(color: Colors.white)),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Widget _row(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("$label: ",
//               style: const TextStyle(color: Colors.white70)),
//           Expanded(
//             child:
//                 Text(value, style: const TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/UpdateProfile.dart';

class RequestStatusPage extends StatefulWidget {
  final String? profileId;

  const RequestStatusPage({super.key, required this.profileId});

  @override
  State<RequestStatusPage> createState() => _RequestStatusPageState();
}

class _RequestStatusPageState extends State<RequestStatusPage> {


  List requests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    final res =
        await dio.get("$baseUrl/request/my-requests/${widget.profileId}");

    setState(() {
      requests = res.data;
      loading = false;
    });
  }

  Future<void> cancelRequest(String requestId) async {
    await dio.put("$baseUrl/request/cancel/$requestId");

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Request Cancelled")));

    fetchRequests();
  }

  bool canCancel(String status) {
    return status == "pending" || status == "approved";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Requests",
            style: TextStyle(color: Color(0xFFFFC107))),
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFFFC107),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: requests.length,
              itemBuilder: (context, i) {
                final r = requests[i];
                final post = r["postId"];

                return Card(
                  color: const Color(0xFF1C1C1C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post["title"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),

                        const SizedBox(height: 6),

                        Text(
                          "Status: ${r["status"]}",
                          style: TextStyle(
                            color: r["status"] == "pending"
                                ? Colors.orange
                                : r["status"] == "approved"
                                    ? Colors.green
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        _row("Hair Length", post["hairLength"].toString()),
                        _row("Hair Type", post["hairType"]),
                        _row("Hair Color", post["hairColor"]),
                        _row("Chemically Treated",
                            post["chemicallyTreated"]),
                        _row("Grey Hair", post["greyHair"]),
                        _row("Quantity", post["quantity"].toString()),
                        _row("Condition", post["condition"]),
                        _row("Location", post["location"]),

                        const SizedBox(height: 6),

                        Text(post["description"],
                            style:
                                const TextStyle(color: Colors.white70)),

                        const SizedBox(height: 12),

                        if (canCancel(r["status"]))
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () => cancelRequest(r["_id"]),
                              child: const Text("CANCEL REQUEST",
                                  style:
                                      TextStyle(color: Colors.white)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
