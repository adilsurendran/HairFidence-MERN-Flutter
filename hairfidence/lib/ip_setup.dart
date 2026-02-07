import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairfidence/login.dart';

/// 🔴 GLOBAL BASE URL (USED EVERYWHERE)
String baseUrl = "";

class IpSetupPage extends StatefulWidget {
  const IpSetupPage({super.key});

  @override
  State<IpSetupPage> createState() => _IpSetupPageState();
}

class _IpSetupPageState extends State<IpSetupPage> {
  final _ip = TextEditingController();
  final _port = TextEditingController();

  final Map<String, String?> errors = {};
  final Color gold = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();
    loadBaseUrl();
  }

  /* =========================
     LOAD SAVED BASE URL
  ========================== */
  Future<void> loadBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("baseUrl");

    if (saved != null && saved.isNotEmpty) {
      baseUrl = saved;

      // Already configured → go login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginpage()),
      );
    }
  }

  /* =========================
     VALIDATION
  ========================== */
  bool validate() {
    errors.clear();

    if (_ip.text.trim().isEmpty) {
      errors["ip"] = "IP address is required";
    } else if (!RegExp(
            r'^((25[0-5]|2[0-4]\d|[0-1]?\d?\d)\.){3}'
            r'(25[0-5]|2[0-4]\d|[0-1]?\d?\d)$')
        .hasMatch(_ip.text)) {
      errors["ip"] = "Invalid IPv4 address";
    }

    if (_port.text.trim().isEmpty) {
      errors["port"] = "Port is required";
    } else if (!RegExp(r'^\d+$').hasMatch(_port.text)) {
      errors["port"] = "Invalid port";
    }

    setState(() {});
    return errors.isEmpty;
  }

  /* =========================
     SET BASE URL (HERE ONLY)
  ========================== */
  Future<void> saveBaseUrl() async {
    if (!validate()) return;

    baseUrl = "http://${_ip.text}:${_port.text}/api";
    print(baseUrl+" \n BaseUrl now set in ipconfig page");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("baseUrl", baseUrl);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: gold,
        centerTitle: true,
        title: const Text(
          "Server Setup",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: const Color(0xFF1C1C1C),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(Icons.router,
                        size: 70, color: Color(0xFFFFC107)),
                  ),
                  const SizedBox(height: 30),

                  _field("IPv4 Address", Icons.computer, _ip, "ip"),
                  _field("Port", Icons.numbers, _port, "port",
                      keyboardType: TextInputType.number),

                  const SizedBox(height: 30),

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
                      onPressed: saveBaseUrl,
                      child: const Text(
                        "SAVE & CONTINUE",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  /* =========================
     INPUT FIELD
  ========================== */
  Widget _field(String label, IconData icon, TextEditingController c, String key,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: c,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(icon, color: gold),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        errors[key] != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  errors[key]!,
                  style:
                      const TextStyle(color: Colors.red, fontSize: 13),
                ),
              )
            : const SizedBox(height: 12),
      ],
    );
  }
}
