// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:hairfidence/DonorRegister.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class DonorAddHairPostPage extends StatefulWidget {
//   const DonorAddHairPostPage({super.key});

//   @override
//   State<DonorAddHairPostPage> createState() => _DonorAddHairPostPageState();
// }

// class _DonorAddHairPostPageState extends State<DonorAddHairPostPage> {
//   final Dio dio = Dio();
//   final _formKey = GlobalKey<FormState>();

//   final Color gold = const Color(0xFFFFC107);

//   final title = TextEditingController();
//   final donationDate = TextEditingController();
//   final hairLength = TextEditingController();
//   final quantity = TextEditingController();
//   final location = TextEditingController();
//   final description = TextEditingController();

//   String hairType = "Straight";
//   String hairColor = "Black";
//   String chemicallyTreated = "no";
//   String greyHair = "no";
//   String condition = "Good";

//   Future<void> pickDate() async {
//     final d = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );

//     if (d != null) {
//       donationDate.text = "${d.day}-${d.month}-${d.year}";
//     }
//   }

//   Future<void> submit() async {
//     final prefs = await SharedPreferences.getInstance();
//     final donorId = prefs.getString("profileId");
//     final ngoId = prefs.getString("ngoId");

//     await dio.post(
//       "$baseUrl/donor-hair-posts",
//       data: {
//         "donorId": donorId,
//         "ngoId": ngoId,
//         "title": title.text,
//         "donationDate": donationDate.text,
//         "hairLength": int.parse(hairLength.text),
//         "hairType": hairType,
//         "hairColor": hairColor,
//         "chemicallyTreated": chemicallyTreated,
//         "greyHair": greyHair,
//         "quantity": int.parse(quantity.text),
//         "condition": condition,
//         "location": location.text,
//         "description": description.text,
//       },
//     );

//     Navigator.pop(context, true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: gold,
//         title: const Text("Add Donation Post",
//             style: TextStyle(color: Colors.black)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _field("Title", title),
//               _dateField(),
//               _field("Hair Length (cm)", hairLength, number: true),
//               _field("Quantity", quantity, number: true),
//               _field("Location", location),
//               _field("Description", description, max: 3),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: gold),
//                 onPressed: submit,
//                 child: const Text("ADD POST",
//                     style: TextStyle(color: Colors.black)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _field(String label, TextEditingController c,
//       {bool number = false, int max = 1}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextFormField(
//         controller: c,
//         maxLines: max,
//         keyboardType: number ? TextInputType.number : null,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.grey),
//           filled: true,
//           fillColor: Colors.black,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none),
//         ),
//       ),
//     );
//   }

//   Widget _dateField() {
//     return TextFormField(
//       controller: donationDate,
//       readOnly: true,
//       onTap: pickDate,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: "Donation Date",
//         labelStyle: const TextStyle(color: Colors.grey),
//         prefixIcon: Icon(Icons.calendar_month, color: gold),
//         filled: true,
//         fillColor: Colors.black,
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/DonorHomePage.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorAddHairPostPage extends StatefulWidget {
  const DonorAddHairPostPage({super.key});

  @override
  State<DonorAddHairPostPage> createState() => _DonorAddHairPostPageState();
}

class _DonorAddHairPostPageState extends State<DonorAddHairPostPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final Color gold = const Color(0xFFFFC107);

  final title = TextEditingController();
  final donationDate = TextEditingController();
  final hairLength = TextEditingController();
  final quantity = TextEditingController();
  final location = TextEditingController();
  final description = TextEditingController();

  String hairType = "Straight";
  String hairColor = "Black";
  String chemicallyTreated = "no";
  String greyHair = "no";
  String condition = "Good";

  /* ===========================
     DATE PICKER
  ============================ */
  Future<void> pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (d != null) {
      donationDate.text = "${d.day}-${d.month}-${d.year}";
    }
  }

  /* ===========================
     SUBMIT
  ============================ */
  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString("profileId");

    await dio.post(
      "$baseUrl/donor-hair-posts",
      data: {
        "donorId": donorId,
        "ngoId": ngoId,
        "title": title.text,
        "donationDate": donationDate.text,
        "hairLength": int.parse(hairLength.text),
        "hairType": hairType,
        "hairColor": hairColor,
        "chemicallyTreated": chemicallyTreated,
        "greyHair": greyHair,
        "quantity": quantity.text.isEmpty
            ? null
            : int.parse(quantity.text),
        "condition": condition,
        "location": location.text,
        "description": description.text,
      },
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /* ===========================
         APP BAR
      ============================ */
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Add Donation Post",
          style: TextStyle(color: Color(0xFFFFC107)),
        ),
      ),

      /* ===========================
         BODY
      ============================ */
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field("Post Title", title, required: true),
              _dateField(),
              _field("Hair Length (cm)", hairLength,
                  number: true, required: true),

              _dropdown(
                label: "Hair Type",
                value: hairType,
                items: ["Straight", "Wavy", "Curly"],
                onChanged: (v) => setState(() => hairType = v),
              ),

              _dropdown(
                label: "Hair Color",
                value: hairColor,
                items: ["Black", "Brown", "Dark Brown", "Mixed"],
                onChanged: (v) => setState(() => hairColor = v),
              ),

              _dropdown(
                label: "Chemically Treated?",
                value: chemicallyTreated,
                items: ["no", "yes"],
                onChanged: (v) =>
                    setState(() => chemicallyTreated = v),
              ),

              _dropdown(
                label: "Grey Hair Present?",
                value: greyHair,
                items: ["no", "yes"],
                onChanged: (v) => setState(() => greyHair = v),
              ),

              _field(
                "Quantity in g (optional)",
                quantity,
                number: true,
                required: false,
              ),

              _dropdown(
                label: "Hair Condition",
                value: condition,
                items: ["Excellent", "Good", "Average"],
                onChanged: (v) => setState(() => condition = v),
              ),

              _field("Location", location, required: true),
              _field("Description", description, max: 3),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                  ),
                  onPressed: submit,
                  child: const Text(
                    "ADD POST",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ===========================
     INPUT FIELD
  ============================ */
  Widget _field(
    String label,
    TextEditingController c, {
    bool number = false,
    int max = 1,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: c,
        maxLines: max,
        keyboardType: number ? TextInputType.number : null,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label),
        validator: required
            ? (v) => v == null || v.isEmpty ? "Required" : null
            : null,
      ),
    );
  }

  /* ===========================
     DROPDOWN
  ============================ */
  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: Colors.black,
        decoration: _decoration(label),
        style: const TextStyle(color: Colors.white),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child:
                    Text(e, style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: (v) => onChanged(v!),
      ),
    );
  }

  /* ===========================
     DATE FIELD
  ============================ */
  Widget _dateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: donationDate,
        readOnly: true,
        onTap: pickDate,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration("Donation Date").copyWith(
          prefixIcon: Icon(Icons.calendar_month, color: gold),
        ),
        validator: (v) =>
            v == null || v.isEmpty ? "Select date" : null,
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
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
