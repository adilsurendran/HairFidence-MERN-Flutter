import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';
// adjust import path if needed

class PatientProfilePage extends StatefulWidget {
  const PatientProfilePage({super.key});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

  final Dio dio = Dio();
class _PatientProfilePageState extends State<PatientProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

  final int currentIndex = 3; // ✅ PROFILE TAB ACTIVE

  bool isEdit = false;
  bool loading = true;

  String? profileId;

  // Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final pin = TextEditingController();
  final district = TextEditingController();
  final dob = TextEditingController();

  String? gender;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  /* ===========================
     FETCH PROFILE
  ============================ */
  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    profileId = prefs.getString("profileId");

    try {
      final res = await dio.get(
        "$baseUrl/patient/$profileId",
      );

      final data = res.data;

      name.text = data["name"];
      email.text = data["email"];
      phone.text = data["phone"];
      address.text = data["address"];
      pin.text = data["pin"];
      district.text = data["district"];
      gender = data["gender"];
      dob.text = data["dob"];
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load profile")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  /* ===========================
     UPDATE PROFILE
  ============================ */
  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await dio.put(
        "$baseUrl/patient/$profileId",
        data: {
          "name": name.text,
          "phone": phone.text,
          "address": address.text,
          "pin": pin.text,
          "district": district.text,
          "gender": gender,
          "dob": dob.text,
        },
      );

      setState(() => isEdit = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update failed")),
      );
    }
  }

  /* ===========================
     DATE PICKER
  ============================ */
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dob.text = "${picked.year}-${picked.month}-${picked.day}";
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,

      /* ===========================
         APP BAR
      ============================ */
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(color: gold, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.close : Icons.edit, color: gold),
            onPressed: () => setState(() => isEdit = !isEdit),
          ),
        ],
      ),

      /* ===========================
         BODY
      ============================ */
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: const Color(0xFF1C1C1C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 70,
                          color: Color(0xFFFFC107),
                        ),
                        const SizedBox(height: 20),

                        _field("Name", Icons.person, name),
                        _field("Email", Icons.email, email, readOnly: true),
                        _field("Phone", Icons.phone, phone),
                        _field("Address", Icons.location_on, address,
                            maxLines: 2),
                        _field("PIN Code", Icons.pin, pin),
                        _field("District", Icons.map, district),

                        _dropdown(
                          "Gender",
                          Icons.people,
                          gender,
                          ["Male", "Female"],
                        ),

                        _dateField(),

                        if (isEdit) const SizedBox(height: 30),

                        if (isEdit)
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gold,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: updateProfile,
                              child: const Text(
                                "UPDATE PROFILE",
                                style: TextStyle(
                                  fontSize: 18,
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

  /* ===========================
     FIELDS
  ============================ */
  Widget _field(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: !isEdit || readOnly,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label, icon),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    IconData icon,
    String? value,
    List<String> items,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label, icon),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child:
                    Text(e, style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: isEdit ? (v) => setState(() => gender = v) : null,
      ),
    );
  }

  Widget _dateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: dob,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration("Date of Birth", Icons.calendar_month),
        onTap: isEdit ? pickDate : null,
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: gold),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    pin.dispose();
    district.dispose();
    dob.dispose();
    super.dispose();
  }
}
