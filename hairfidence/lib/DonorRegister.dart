import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:hairfidence/login.dart';


class DonorRegister extends StatefulWidget {
  const DonorRegister({super.key});

  @override
  State<DonorRegister> createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {
  final Dio dio = Dio();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _pin = TextEditingController();
  final _district = TextEditingController();
  final _password = TextEditingController();
  final _dob = TextEditingController();

  String? selectedGender;
  String? selectedNgoId;
  bool isLoading = false;

  /// ERROR MAP (INLINE VALIDATION)
  final Map<String, String?> errors = {};

  /// NGO DATA
  List ngos = [];
  List filteredNgos = [];

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
    } catch (_) {}
  }

  /// SEARCH NGO
  void searchNgo(String value) {
    setState(() {
      filteredNgos = ngos.where((ngo) {
        return ngo["name"].toString().toLowerCase().contains(value.toLowerCase()) ||
            ngo["place"].toString().toLowerCase().contains(value.toLowerCase()) ||
            ngo["pincode"].toString().contains(value);
      }).toList();
    });
  }

  /// DATE PICKER
  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _dob.text = "${picked.year}-${picked.month}-${picked.day}");
    }
  }

  /// =====================
  /// VALIDATION
  /// =====================
  bool validate() {
    errors.clear();

    if (_name.text.trim().isEmpty) errors["name"] = "Name is required";
    if (_email.text.trim().isEmpty) {
      errors["email"] = "Email is required";
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(_email.text)) {
      errors["email"] = "Enter a valid email";
    }

    if (_phone.text.trim().isEmpty) {
      errors["phone"] = "Phone number is required";
    } else if (!RegExp(r'^\d{10}$').hasMatch(_phone.text)) {
      errors["phone"] = "Phone must be exactly 10 digits";
    }

    if (_password.text.trim().isEmpty) {
      errors["password"] = "Password is required";
    } else if (_password.text.length < 6) {
      errors["password"] = "Minimum 6 characters required";
    }

    if (_address.text.trim().isEmpty) errors["address"] = "Address is required";

    if (_pin.text.trim().isEmpty) {
      errors["pin"] = "PIN is required";
    } else if (!RegExp(r'^\d{6}$').hasMatch(_pin.text)) {
      errors["pin"] = "PIN must be exactly 6 digits";
    }

    if (_district.text.trim().isEmpty) errors["district"] = "District is required";
    if (_dob.text.trim().isEmpty) errors["dob"] = "Date of birth is required";
    if (selectedGender == null) errors["gender"] = "Gender is required";
    if (selectedNgoId == null) errors["ngo"] = "Please select an NGO";

    setState(() {});
    return errors.isEmpty;
  }

  /// =====================
  /// REGISTER DONOR
  /// =====================
  Future<void> registerDonor() async {
    if (!validate()) return;

    setState(() => isLoading = true);

    try {
      await dio.post(
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
          "ngoId": selectedNgoId,
        },
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Loginpage()),
        (_) => false,
      );
    } catch (_) {} finally {
      setState(() => isLoading = false);
    }
  }

  /// =====================
  /// UI
  /// =====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Register as Donor",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _field("Name", Icons.person, _name, "name"),
                _field("Email", Icons.email, _email, "email"),
                _field("Phone", Icons.phone, _phone, "phone"),
                _field("Address", Icons.location_on, _address, "address"),
                _field("PIN", Icons.pin, _pin, "pin"),
                _field("District", Icons.map, _district, "district"),
                _field("Password", Icons.lock, _password, "password", obscure: true),

                DropdownButtonFormField<String>(
                  decoration: _decoration("Gender", Icons.people),
                  dropdownColor: Colors.black,
                  items: ["Male", "Female"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => selectedGender = v),
                ),
                _error("gender"),

                const SizedBox(height: 10),

                TextFormField(
                  controller: _dob,
                  readOnly: true,
                  onTap: selectDate,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration("Date of Birth", Icons.calendar_month),
                ),
                _error("dob"),

                const SizedBox(height: 16),

                TextFormField(
                  onChanged: searchNgo,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration("Search NGO", Icons.search),
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  decoration: _decoration("Select NGO", Icons.business),
                  dropdownColor: Colors.black,
                  items: filteredNgos
                      .map<DropdownMenuItem<String>>((ngo) => DropdownMenuItem(
                            value: ngo["_id"],
                            child: Text("${ngo["name"]} - ${ngo["place"]}",
                                style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => selectedNgoId = v),
                ),
                _error("ngo"),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : registerDonor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text("REGISTER",
                            style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =====================
  /// HELPERS
  /// =====================
  Widget _field(String label, IconData icon, TextEditingController c, String key,
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: c,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: _decoration(label, icon),
        ),
        _error(key),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _error(String key) {
    return errors[key] != null
        ? Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(errors[key]!,
                style: const TextStyle(color: Colors.red, fontSize: 13)),
          )
        : const SizedBox.shrink();
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: const Color(0xFFFFC107)),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
