// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hairfidence/DonorRegister.dart';
// import 'package:hairfidence/login.dart';


// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final Dio dio = Dio();

//   // Controllers
//   final TextEditingController _name = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _phone = TextEditingController();
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _pin = TextEditingController();
//   final TextEditingController _district = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _dob = TextEditingController();

//   String? selectedGender;
//   bool isLoading = false;

//   /// DATE PICKER
//   Future<void> selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _dob.text =
//             "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
//       });
//     }
//   }

//   /// REGISTER API (PATIENT ONLY)
//   Future<void> registerUser() async {
//     if (_name.text.isEmpty ||
//         _email.text.isEmpty ||
//         _phone.text.isEmpty ||
//         _address.text.isEmpty ||
//         _pin.text.isEmpty ||
//         _district.text.isEmpty ||
//         _password.text.isEmpty ||
//         selectedGender == null ||
//         _dob.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("All fields are required")),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final response = await dio.post(
//         "$baseUrl/register/patient",
//         data: {
//           "name": _name.text,
//           "email": _email.text,
//           "phone": _phone.text,
//           "address": _address.text,
//           "pin": _pin.text,
//           "district": _district.text,
//           "password": _password.text,
//           "gender": selectedGender,
//           "dob": _dob.text,
//           "role": "patient", // ✅ FIXED ROLE
//         },
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response.data["message"] ?? "Registered successfully"),
//         ),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => const Loginpage()),
//           (route) => false,
//         );
//       }

//       _name.clear();
//       _email.clear();
//       _phone.clear();
//       _address.clear();
//       _pin.clear();
//       _district.clear();
//       _password.clear();
//       _dob.clear();
//       setState(() => selectedGender = null);
//     } on DioException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.response?.data["message"] ?? "Registration failed"),
//         ),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "Register as User", // ✅ UPDATED TITLE
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFFFFC107),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Card(
//             color: const Color(0xFF1C1C1C),
//             elevation: 10,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 children: [
//                   const Icon(
//                     Icons.person_add_alt_1,
//                     size: 70,
//                     color: Color(0xFFFFC107),
//                   ),
//                   const SizedBox(height: 20),

//                   _inputField("Name", Icons.person, _name),
//                   _inputField("Email", Icons.email, _email,
//                       keyboardType: TextInputType.emailAddress),
//                   _inputField("Phone", Icons.phone, _phone,
//                       keyboardType: TextInputType.phone),
//                   _inputField("Address", Icons.location_on, _address),
//                   _inputField("PIN Code", Icons.pin, _pin,
//                       keyboardType: TextInputType.number),
//                   _inputField("District", Icons.map, _district),
//                   _inputField("Password", Icons.lock, _password,
//                       isPassword: true),

//                   const SizedBox(height: 16),

//                   DropdownButtonFormField<String>(
//                     dropdownColor: Colors.black,
//                     decoration: _inputDecoration("Gender", Icons.people),
//                     style: const TextStyle(color: Colors.white),
//                     initialValue: selectedGender,
//                     items: ["Male", "Female"]
//                         .map(
//                           (e) => DropdownMenuItem(
//                             value: e,
//                             child: Text(
//                               e,
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                     onChanged: (value) =>
//                         setState(() => selectedGender = value),
//                   ),

//                   const SizedBox(height: 16),

//                   TextFormField(
//                     controller: _dob,
//                     readOnly: true,
//                     style: const TextStyle(color: Colors.white),
//                     decoration:
//                         _inputDecoration("Date of Birth", Icons.calendar_month),
//                     onTap: () => selectDate(context),
//                   ),

//                   const SizedBox(height: 30),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFFC107),
//                         foregroundColor: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       onPressed: isLoading ? null : registerUser,
//                       child: isLoading
//                           ? const CircularProgressIndicator(color: Colors.black)
//                           : const Text(
//                               "REGISTER",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// INPUT FIELD
//   Widget _inputField(
//     String label,
//     IconData icon,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     bool isPassword = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: isPassword,
//         style: const TextStyle(color: Colors.white),
//         decoration: _inputDecoration(label, icon),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       prefixIcon: Icon(icon, color: const Color(0xFFFFC107)),
//       filled: true,
//       fillColor: Colors.black,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide.none,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:hairfidence/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final Dio dio = Dio();

  // Controllers
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

  /// INLINE ERRORS (LIKE DONOR)
  final Map<String, String?> errors = {};

  final Color gold = const Color(0xFFFFC107);

  /* =========================
     DATE PICKER
  ========================== */
  Future<void> selectDate() async {
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
        errors.remove("dob");
      });
    }
  }

  /* =========================
     VALIDATION
  ========================== */
  bool validate() {
    errors.clear();

    if (_name.text.trim().isEmpty) {
      errors["name"] = "Name is required";
    }

    if (_email.text.trim().isEmpty) {
      errors["email"] = "Email is required";
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(_email.text)) {
      errors["email"] = "Enter a valid email";
    }

    if (_phone.text.trim().isEmpty) {
      errors["phone"] = "Phone number is required";
    } else if (!RegExp(r'^\d{10}$').hasMatch(_phone.text)) {
      errors["phone"] = "Phone must be exactly 10 digits";
    }

    if (_address.text.trim().isEmpty) {
      errors["address"] = "Address is required";
    }

    if (_pin.text.trim().isEmpty) {
      errors["pin"] = "PIN is required";
    } else if (!RegExp(r'^\d{6}$').hasMatch(_pin.text)) {
      errors["pin"] = "PIN must be exactly 6 digits";
    }

    if (_district.text.trim().isEmpty) {
      errors["district"] = "District is required";
    }

    if (_password.text.trim().isEmpty) {
      errors["password"] = "Password is required";
    } else if (_password.text.length < 6) {
      errors["password"] = "Minimum 6 characters required";
    }

    if (selectedGender == null) {
      errors["gender"] = "Gender is required";
    }

    if (_dob.text.trim().isEmpty) {
      errors["dob"] = "Date of birth is required";
    }

    setState(() {});
    return errors.isEmpty;
  }

  /* =========================
     REGISTER PATIENT
  ========================== */
  Future<void> registerUser() async {
    if (!validate()) return;

    setState(() => isLoading = true);

    try {
      await dio.post(
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
          "role": "patient",
        },
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Loginpage()),
        (_) => false,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  /* =========================
     UI
  ========================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Register as User",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: gold,
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
                  const Icon(Icons.person_add_alt_1,
                      size: 70, color: Color(0xFFFFC107)),
                  const SizedBox(height: 20),

                  _field("Name", Icons.person, _name, "name"),
                  _field("Email", Icons.email, _email, "email",
                      keyboardType: TextInputType.emailAddress),
                  _field("Phone", Icons.phone, _phone, "phone",
                      keyboardType: TextInputType.phone),
                  _field("Address", Icons.location_on, _address, "address"),
                  _field("PIN Code", Icons.pin, _pin, "pin",
                      keyboardType: TextInputType.number),
                  _field("District", Icons.map, _district, "district"),
                  _field("Password", Icons.lock, _password, "password",
                      isPassword: true),

                  DropdownButtonFormField<String>(
                    decoration: _decoration("Gender", Icons.people),
                    dropdownColor: Colors.black,
                    items: ["Male", "Female"]
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,
                                  style:
                                      const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => selectedGender = v),
                  ),
                  _error("gender"),

                  const SizedBox(height: 12),

                  TextField(
                    controller: _dob,
                    readOnly: true,
                    onTap: selectDate,
                    style: const TextStyle(color: Colors.white),
                    decoration:
                        _decoration("Date of Birth", Icons.calendar_month),
                  ),
                  _error("dob"),

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
                      onPressed: isLoading ? null : registerUser,
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.black)
                          : const Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 18,
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

  /* =========================
     HELPERS
  ========================== */
  Widget _field(String label, IconData icon, TextEditingController c,
      String key,
      {TextInputType keyboardType = TextInputType.text,
      bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: c,
          keyboardType: keyboardType,
          obscureText: isPassword,
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
            child: Text(
              errors[key]!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          )
        : const SizedBox.shrink();
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
}
