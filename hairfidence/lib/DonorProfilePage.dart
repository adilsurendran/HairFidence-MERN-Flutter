import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DonorProfilePage extends StatefulWidget {
  const DonorProfilePage({super.key});

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

  bool isEdit = false;
  bool loading = true;

  String? donorId;
  String? selectedNgoId;

  /// Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final pin = TextEditingController();
  final district = TextEditingController();
  final dob = TextEditingController();

  String? gender;

  /// NGO
  List ngos = [];
  List filteredNgos = [];

  @override
  void initState() {
    super.initState();
    fetchProfile();
    fetchNgos();
  }

  /* ===============================
     FETCH DONOR PROFILE
  =============================== */
  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    donorId = prefs.getString("profileId");

    try {
      final res = await dio.get("$baseUrl/donor/profile/$donorId");
      print(res.data);
      final d = res.data;

      name.text = d["name"];
      email.text = d["email"];
      phone.text = d["phone"];
      address.text = d["address"];
      pin.text = d["pin"];
      district.text = d["district"];
      gender = d["gender"];
      dob.text = d["dob"];
      selectedNgoId = d["ngoId"];
    } catch (_) {
      _snack("Failed to load profile");
    } finally {
      setState(() => loading = false);
    }
  }

  /* ===============================
     FETCH NGOS
  =============================== */
  Future<void> fetchNgos() async {
    try {
      final res = await dio.get("$baseUrl/ngos");
      setState(() {
        ngos = res.data;
        filteredNgos = ngos;
      });
    } catch (_) {
      _snack("Failed to load NGOs");
    }
  }

  /* ===============================
     SEARCH NGO
  =============================== */
  void searchNgo(String value) {
    setState(() {
      filteredNgos = ngos.where((ngo) {
        return ngo["name"]
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            ngo["place"]
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            ngo["pincode"].toString().contains(value);
      }).toList();
    });
  }

  /* ===============================
     UPDATE PROFILE
  =============================== */
  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await dio.put(
        "$baseUrl/donor/$donorId",
        data: {
          "name": name.text,
          "phone": phone.text,
          "address": address.text,
          "pin": pin.text,
          "district": district.text,
          "gender": gender,
          "dob": dob.text,
          "ngoId": selectedNgoId,
        },
      );

      setState(() => isEdit = false);
      _snack("Profile updated successfully");
    } catch (_) {
      _snack("Update failed");
    }
  }

  /* ===============================
     DATE PICKER
  =============================== */
  Future<void> pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (d != null) {
      dob.text = "${d.year}-${d.month}-${d.day}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        title: Text("My Profile",
            style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(isEdit ? Icons.close : Icons.edit, color: gold),
            onPressed: () => setState(() => isEdit = !isEdit),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                color: const Color(0xFF1C1C1C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Icon(Icons.person,
                            size: 70, color: Color(0xFFFFC107)),
                        const SizedBox(height: 20),

                        _field("Name", Icons.person, name),
                        _field("Email", Icons.email, email, readOnly: true),
                        _field("Phone", Icons.phone, phone),
                        _field("Address", Icons.location_on, address, max: 2),
                        _field("PIN", Icons.pin, pin),
                        _field("District", Icons.map, district),

                        _dropdown("Gender", Icons.people, gender,
                            ["Male", "Female"]),

                        _dateField(),

                        if (isEdit) ...[
                          const SizedBox(height: 10),

                          /// NGO SEARCH
                          TextFormField(
                            onChanged: searchNgo,
                            style: const TextStyle(color: Colors.white),
                            decoration: _decoration(
                                "Search NGO (name/place/pin)", Icons.search),
                          ),

                          const SizedBox(height: 12),

                          /// NGO SELECT
                          DropdownButtonFormField<String>(
                            initialValue: selectedNgoId,
                            dropdownColor: Colors.black,
                            decoration:
                                _decoration("Select NGO", Icons.business),
                            items: filteredNgos
                                .map<DropdownMenuItem<String>>(
                                  (ngo) => DropdownMenuItem(
                                    value: ngo["_id"],
                                    child: Text(
                                      "${ngo["name"]} - ${ngo["place"]}",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => selectedNgoId = v),
                          ),
                        ],

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
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: updateProfile,
                              child: const Text("UPDATE PROFILE",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
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

  /* ===============================
     HELPERS
  =============================== */
  Widget _field(String label, IconData icon, TextEditingController c,
      {bool readOnly = false, int max = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        readOnly: !isEdit || readOnly,
        maxLines: max,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label, icon),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _dropdown(
      String label, IconData icon, String? value, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: Colors.black,
        decoration: _decoration(label, icon),
        items: items
            .map((e) => DropdownMenuItem(
                value: e,
                child:
                    Text(e, style: const TextStyle(color: Colors.white))))
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
          borderSide: BorderSide.none),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
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
