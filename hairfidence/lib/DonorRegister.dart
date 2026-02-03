import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/login.dart';

String baseUrl = "http://192.168.1.35:8000/api";

class DonorRegister extends StatefulWidget {
  const DonorRegister({super.key});

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  final Dio dio = Dio();

  // Form controllers
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _pin = TextEditingController();
  final _district = TextEditingController();
  final _password = TextEditingController();
  final _dob = TextEditingController();

  String? selectedGender;
  bool isLoading = false;

  /// NGO
  List ngos = [];
  List filteredNgos = [];
  String? selectedNgoId;

  @override
  void initState() {
    super.initState();
    fetchNgos();
  }

  /// FETCH NGOS
  Future<void> fetchNgos() async {
    try {
      final res = await dio.get("$baseUrl/ngos");
      setState(() {
        ngos = res.data;
        filteredNgos = ngos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load NGOs")),
      );
    }
  }

  /// SEARCH NGO
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
            ngo["pincode"]
                .toString()
                .contains(value);
      }).toList();
    });
  }

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dob.text = "${picked.year}-${picked.month}-${picked.day}";
      setState(() {});
    }
  }

  /// REGISTER DONOR
  Future<void> registerDonor() async {
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _phone.text.isEmpty ||
        _address.text.isEmpty ||
        _pin.text.isEmpty ||
        _district.text.isEmpty ||
        _password.text.isEmpty ||
        _dob.text.isEmpty ||
        selectedGender == null ||
        selectedNgoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields including NGO are required")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await dio.post(
        "$baseUrl/register/donor",
        data: {
          "name": _name.text,
          "email": _email.text,
          "phone": _phone.text,
          "address": _address.text,
          "pin": _pin.text,
          "district": _district.text,
          "password": _password.text,
          "gender": selectedGender,
          "dob": _dob.text,
          "role": "donor",
          "ngoId": selectedNgoId, // ✅ IMPORTANT
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res.data["message"] ?? "Registered")),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Loginpage()),
        (_) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration failed")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Register as Donor",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _field("Name", Icons.person, _name),
                _field("Email", Icons.email, _email),
                _field("Phone", Icons.phone, _phone),
                _field("Address", Icons.location_on, _address),
                _field("PIN", Icons.pin, _pin),
                _field("District", Icons.map, _district),
                _field("Password", Icons.lock, _password, obscure: true),

                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  decoration: _decoration("Gender", Icons.people),
                  items: ["Male", "Female"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e,
                                style:
                                    const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => selectedGender = v,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _dob,
                  readOnly: true,
                  onTap: () => selectDate(context),
                  style: const TextStyle(color: Colors.white),
                  decoration:
                      _decoration("Date of Birth", Icons.calendar_month),
                ),

                const SizedBox(height: 20),

                /// NGO SEARCH
                TextFormField(
                  onChanged: searchNgo,
                  style: const TextStyle(color: Colors.white),
                  decoration:
                      _decoration("Search NGO (name/place/pin)", Icons.search),
                ),

                const SizedBox(height: 12),

                /// NGO SELECT
                DropdownButtonFormField<String>(
                  dropdownColor: Colors.black,
                  decoration: _decoration("Select NGO", Icons.business),
                  items: filteredNgos
                      .map<DropdownMenuItem<String>>(
                        (ngo) => DropdownMenuItem(
                          value: ngo["_id"],
                          child: Text(
                            "${ngo["name"]} - ${ngo["place"]}",
                            style:
                                const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => selectedNgoId = value,
                ),

                const SizedBox(height: 30),

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
                    onPressed: isLoading ? null : registerDonor,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text(
                            "REGISTER",
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
    );
  }

  Widget _field(String label, IconData icon, TextEditingController c,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label, icon),
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: const Color(0xFFFFC107)),
      filled: true,
      fillColor: Colors.black,
      border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
