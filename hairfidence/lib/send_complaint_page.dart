import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SendComplaintPage extends StatefulWidget {
  const SendComplaintPage({super.key});

  @override
  State<SendComplaintPage> createState() => _SendComplaintPageState();
}

class _SendComplaintPageState extends State<SendComplaintPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final subject = TextEditingController();
  final message = TextEditingController();

  bool loading = false;

  Future<void> submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final profileId = prefs.getString("profileId");

    setState(() => loading = true);

    try {
      await dio.post(
        "$baseUrl/complaints",
        data: {
          "senderId": profileId,
          "senderRole": "patient",
          "subject": subject.text.trim(),
          "message": message.text.trim(),
        },
      );

      subject.clear();
      message.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complaint submitted")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Submission failed")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Send Complaint",
            style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: subject,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dec("Subject"),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: message,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dec("Complaint Message"),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: loading ? null : submitComplaint,
                      child: loading
                          ? const CircularProgressIndicator(
                              color: Colors.black)
                          : const Text(
                              "SUBMIT COMPLAINT",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
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

  InputDecoration _dec(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.black,
      border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
