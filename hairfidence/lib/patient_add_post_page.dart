import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientAddPostPage extends StatefulWidget {
  const PatientAddPostPage({super.key});

  @override
  State<PatientAddPostPage> createState() => _PatientAddPostPageState();
}

class _PatientAddPostPageState extends State<PatientAddPostPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final hairLength = TextEditingController();
  final hairColor = TextEditingController();
  final quantity = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();

  String? hairType;
  bool loading = false;

  Future<void> submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final patientId = prefs.getString("profileId");

    try {
      setState(() => loading = true);

      await dio.post(
        "$baseUrl/patient-posts",
        data: {
          "patientId": patientId,
          "hairLength": hairLength.text,
          "hairType": hairType,
          "hairColor": hairColor.text,
          "quantity": quantity.text,
          "location": location.text,
          "description": description.text,
        },
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to add post")));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Hair Post",
            style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFFC107),
      ),
      body: SingleChildScrollView(
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
                  _field("Hair Length (cm)", hairLength),
                  _dropdown(),
                  _field("Hair Color", hairColor),
                  _field("Quantity (grams)", quantity),
                  _field("Location", location),
                  _field("Description", description, maxLines: 3),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: loading ? null : submitPost,
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text("POST"),
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

  Widget _field(String label, TextEditingController c,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _dropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.black,
        decoration: _decoration("Hair Type"),
        items: ["Straight", "Wavy", "Curly"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child:
                      Text(e, style: const TextStyle(color: Colors.white)),
                ))
            .toList(),
        onChanged: (v) => hairType = v,
        validator: (v) => v == null ? "Select hair type" : null,
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
    );
  }
}
