import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorHomePage.dart';
import 'package:hairfidence/PatientHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/Register.dart';

String baseUrl = "http://192.168.1.35:8000/api";

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final Dio dio = Dio();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  /// ============================
  /// LOGIN API
  /// ============================
  Future<void> loginUser() async {
    if (_username.text.isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username & Password required")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final res = await dio.post(
        "$baseUrl/auth/login",
        data: {
          "username": _username.text,
          "password": _password.text,
        },
      );
print(res.data);
      final data = res.data;

      /// STORE DATA GLOBALLY
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("loginId", data["loginId"]);
      await prefs.setString("profileId", data["profileId"] ?? "");
      await prefs.setString("role", data["role"]);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"] ?? "Login successful")),
      );

      /// ROLE BASED NAVIGATION (PLUG YOUR PAGES)
      switch (data["role"]) {
        case "donor":
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const DonorHomePage()));
          break;

        case "patient":
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const PatientHomePage()));
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid role")),
          );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data["message"] ?? "Login failed",
          ),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// ============================
  /// UI
  /// ============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: const Color(0xFF1C1C1C),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 70,
                    color: Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 20),

                  /// USERNAME
                  _field("Username", Icons.person, _username),

                  /// PASSWORD
                  _field("Password", Icons.lock, _password, obscure: true),

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
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
                      onPressed: isLoading ? null : loginUser,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                          : const Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "REGISTER AS",
                    style: TextStyle(color: Color(0xFFFFC107)),
                  ),

                  const SizedBox(height: 12),

                  /// REGISTER BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: _registerButton(
                          "Patient",
                          Icons.local_hospital,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Register()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _registerButton(
                          "Donor",
                          Icons.volunteer_activism,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DonorRegister()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ============================
  /// REUSABLE WIDGETS
  /// ============================
  Widget _field(String label, IconData icon, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFFFFC107)),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _registerButton(
      String text, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFC107)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFFFFC107), size: 18),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFFFFC107),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
