import 'package:flutter/material.dart';

class PatientFeedbackPage extends StatefulWidget {
  const PatientFeedbackPage({super.key});

  @override
  State<PatientFeedbackPage> createState() => _PatientFeedbackPageState();
}

class _PatientFeedbackPageState extends State<PatientFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Patient Feedback",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.feedback,
                    size: 70,
                    color: Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 20),

                  /// Feedback Message Field
                  TextFormField(
                    controller: feedbackController,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Your Feedback",
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon:
                          const Icon(Icons.message, color: Color(0xFFFFC107)),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Feedback cannot be empty"
                        : null,
                  ),

                  const SizedBox(height: 20),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Feedback submitted successfully!")),
                          );
                          feedbackController.clear();
                        }
                      },
                      child: const Text(
                        "SUBMIT FEEDBACK",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
}
