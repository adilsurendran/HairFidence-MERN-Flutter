// import 'package:flutter/material.dart';

// class PatientFeedbackPage extends StatefulWidget {
//   const PatientFeedbackPage({super.key});

//   @override
//   State<PatientFeedbackPage> createState() => _PatientFeedbackPageState();
// }

// class _PatientFeedbackPageState extends State<PatientFeedbackPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController feedbackController = TextEditingController();

//   @override
//   void dispose() {
//     feedbackController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "Patient Feedback",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFFFFC107),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           color: const Color(0xFF1C1C1C),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: 8,
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const Icon(
//                     Icons.feedback,
//                     size: 70,
//                     color: Color(0xFFFFC107),
//                   ),
//                   const SizedBox(height: 20),

//                   /// Feedback Message Field
//                   TextFormField(
//                     controller: feedbackController,
//                     maxLines: 6,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Your Feedback",
//                       labelStyle: const TextStyle(color: Colors.grey),
//                       prefixIcon:
//                           const Icon(Icons.message, color: Color(0xFFFFC107)),
//                       filled: true,
//                       fillColor: Colors.black,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                     validator: (value) => value == null || value.isEmpty
//                         ? "Feedback cannot be empty"
//                         : null,
//                   ),

//                   const SizedBox(height: 20),

//                   /// Submit Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFFC107),
//                         foregroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text(
//                                     "Feedback submitted successfully!")),
//                           );
//                           feedbackController.clear();
//                         }
//                       },
//                       child: const Text(
//                         "SUBMIT FEEDBACK",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController feedbackController =
      TextEditingController();

  bool loading = false;

  /* ===============================
     SUBMIT FEEDBACK
  =============================== */
  Future<void> submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final profileId = prefs.getString("profileId");

    setState(() => loading = true);

    try {
      await dio.post(
        "$baseUrl/feedback",
        data: {
          "senderId": profileId,
          "senderRole": "patient",
          "message": feedbackController.text.trim(),
        },
      );

      feedbackController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Feedback sent successfully"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to send feedback"),
        ),
      );
    } finally {
      setState(() => loading = false);
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
          "Send Feedback",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),

      /* ===============================
         BODY
      =============================== */
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.feedback,
                    color: Color(0xFFFFC107),
                    size: 60,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: feedbackController,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Write your feedback here...",
                      hintStyle:
                          const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty
                            ? "Feedback cannot be empty"
                            : null,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
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
                      onPressed:
                          loading ? null : submitFeedback,
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              "SEND FEEDBACK",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
