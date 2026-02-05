import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/login.dart';

String baseUrl = "http://192.168.1.36:8000/api"; // change if needed

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Dio dio = Dio();

  // Controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pin = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  String? selectedGender;
  bool isLoading = false;

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dob.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  /// REGISTER API (PATIENT ONLY)
  Future<void> registerUser() async {
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _phone.text.isEmpty ||
        _address.text.isEmpty ||
        _pin.text.isEmpty ||
        _district.text.isEmpty ||
        _password.text.isEmpty ||
        selectedGender == null ||
        _dob.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await dio.post(
        "$baseUrl/register/patient",
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
          "role": "patient", // ✅ FIXED ROLE
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data["message"] ?? "Registered successfully"),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Loginpage()),
          (route) => false,
        );
      }

      _name.clear();
      _email.clear();
      _phone.clear();
      _address.clear();
      _pin.clear();
      _district.clear();
      _password.clear();
      _dob.clear();
      setState(() => selectedGender = null);
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response?.data["message"] ?? "Registration failed"),
        ),
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
          "Register as User", // ✅ UPDATED TITLE
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: const Color(0xFF1C1C1C),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.person_add_alt_1,
                    size: 70,
                    color: Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 20),

                  _inputField("Name", Icons.person, _name),
                  _inputField("Email", Icons.email, _email,
                      keyboardType: TextInputType.emailAddress),
                  _inputField("Phone", Icons.phone, _phone,
                      keyboardType: TextInputType.phone),
                  _inputField("Address", Icons.location_on, _address),
                  _inputField("PIN Code", Icons.pin, _pin,
                      keyboardType: TextInputType.number),
                  _inputField("District", Icons.map, _district),
                  _inputField("Password", Icons.lock, _password,
                      isPassword: true),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    decoration: _inputDecoration("Gender", Icons.people),
                    style: const TextStyle(color: Colors.white),
                    initialValue: selectedGender,
                    items: ["Male", "Female"]
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedGender = value),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _dob,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration:
                        _inputDecoration("Date of Birth", Icons.calendar_month),
                    onTap: () => selectDate(context),
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
                      onPressed: isLoading ? null : registerUser,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              "REGISTER",
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

  /// INPUT FIELD
  Widget _inputField(
    String label,
    IconData icon,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label, icon),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: const Color(0xFFFFC107)),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
