// import 'package:flutter/material.dart';

// class AddManageReportPage extends StatefulWidget {
//   const AddManageReportPage({super.key});

//   @override
//   State<AddManageReportPage> createState() => _AddManageReportPageState();
// }

// class _AddManageReportPageState extends State<AddManageReportPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController hospitalController = TextEditingController();
//   final TextEditingController dateController = TextEditingController();

//   String? reportType;

//   final List<Map<String, String>> reports = [
//     {
//       "title": "Blood Test",
//       "type": "Blood Test",
//       "date": "12/09/2025",
//       "hospital": "City Lab"
//     },
//     {
//       "title": "X-Ray Report",
//       "type": "Scan / X-Ray",
//       "date": "05/08/2025",
//       "hospital": "Apollo Hospital"
//     }
//   ];

//   Future<void> selectDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       dateController.text =
//           "${picked.day}/${picked.month}/${picked.year}";
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "Add & Manage Reports",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFFFFC107),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// ================= ADD REPORT =================
//             Card(
//               color: const Color(0xFF1C1C1C),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               elevation: 8,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Add Report",
//                         style: TextStyle(
//                             color: Color(0xFFFFC107),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20),

//                       _inputField("Report Title", titleController),
//                       _dropdownField(),
//                       _inputField("Hospital / Lab", hospitalController),
//                       _dateField(),

//                       const SizedBox(height: 20),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 45,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFFFC107),
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15)),
//                           ),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               setState(() {
//                                 reports.add({
//                                   "title": titleController.text,
//                                   "type": reportType!,
//                                   "date": dateController.text,
//                                   "hospital": hospitalController.text,
//                                 });
//                               });

//                               titleController.clear();
//                               hospitalController.clear();
//                               dateController.clear();
//                               reportType = null;

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content:
//                                         Text("Report added successfully")),
//                               );
//                             }
//                           },
//                           child: const Text(
//                             "ADD REPORT",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             /// ================= MANAGE REPORTS =================
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Manage Reports",
//                 style: TextStyle(
//                     color: Color(0xFFFFC107),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 10),

//             reports.isEmpty
//                 ? const Text("No reports added",
//                     style: TextStyle(color: Colors.grey))
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: reports.length,
//                     itemBuilder: (context, index) {
//                       return _reportCard(reports[index], index);
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= WIDGETS =================

//   Widget _inputField(String label, TextEditingController controller) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         style: const TextStyle(color: Colors.white),
//         decoration: _decoration(label),
//         validator: (v) => v == null || v.isEmpty ? "Required field" : null,
//       ),
//     );
//   }

//   Widget _dropdownField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: DropdownButtonFormField<String>(
//         initialValue: reportType,
//         dropdownColor: Colors.black,
//         style: const TextStyle(color: Colors.white),
//         decoration: _decoration("Report Type"),
//         items: [
//           "Blood Test",
//           "Scan / X-Ray",
//           "Prescription",
//           "Other"
//         ]
//             .map((e) => DropdownMenuItem(
//                   value: e,
//                   child: Text(e,
//                       style: const TextStyle(color: Colors.white)),
//                 ))
//             .toList(),
//         onChanged: (value) => setState(() => reportType = value),
//         validator: (value) =>
//             value == null ? "Select report type" : null,
//       ),
//     );
//   }

//   Widget _dateField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: dateController,
//         readOnly: true,
//         style: const TextStyle(color: Colors.white),
//         decoration: _decoration("Report Date"),
//         onTap: selectDate,
//         validator: (v) => v == null || v.isEmpty ? "Select date" : null,
//       ),
//     );
//   }

//   Widget _reportCard(Map<String, String> report, int index) {
//     return Card(
//       color: const Color(0xFF1C1C1C),
//       shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(report["title"]!,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 6),
//             _infoRow("Type", report["type"]!),
//             _infoRow("Date", report["date"]!),
//             _infoRow("Hospital", report["hospital"]!),
//             const SizedBox(height: 10),

//             Align(
//               alignment: Alignment.centerRight,
//               child: IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   setState(() {
//                     reports.removeAt(index);
//                   });
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(String title, String value) {
//     return Row(
//       children: [
//         Text("$title : ",
//             style: const TextStyle(color: Colors.grey)),
//         Expanded(
//           child: Text(value,
//               style: const TextStyle(color: Colors.white)),
//         ),
//       ],
//     );
//   }

//   InputDecoration _decoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: const TextStyle(color: Colors.grey),
//       filled: true,
//       fillColor: Colors.black,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: BorderSide.none),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hairfidence/Register.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddManageReportPage extends StatefulWidget {
  const AddManageReportPage({super.key});

  @override
  State<AddManageReportPage> createState() => _AddManageReportPageState();
}

class _AddManageReportPageState extends State<AddManageReportPage> {
  final Dio dio = Dio();
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final hospitalController = TextEditingController();
  final dateController = TextEditingController();

  String? reportType;
  String? patientId;

  Uint8List? webImage;
  XFile? pickedFile;

  bool loading = false;
  List reports = [];

  final Color gold = const Color(0xFFFFC107);

  @override
  void initState() {
    super.initState();
    loadPatientId();
  }

  /* =============================
     LOAD PATIENT ID
  ============================== */
  Future<void> loadPatientId() async {
    final prefs = await SharedPreferences.getInstance();
    patientId = prefs.getString("profileId");
    fetchReports();
  }

  /* =============================
     PICK IMAGE (WEB + MOBILE)
  ============================== */
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      if (kIsWeb) {
        webImage = await file.readAsBytes();
      } else {
        pickedFile = file;
      }
      setState(() {});
    }
  }

  /* =============================
     PICK DATE
  ============================== */
  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateController.text =
          "${picked.year}-${picked.month}-${picked.day}";
      setState(() {});
    }
  }

  /* =============================
     ADD REPORT
  ============================== */
  Future<void> addReport() async {
    if (!_formKey.currentState!.validate() ||
        (pickedFile == null && webImage == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields & image required")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      final formData = FormData.fromMap({
        "patientId": patientId,
        "title": titleController.text,
        "reportType": reportType,
        "hospital": hospitalController.text,
        "reportDate": dateController.text,
        "image": kIsWeb
            ? MultipartFile.fromBytes(webImage!,
                filename: "prescription.png")
            : await MultipartFile.fromFile(pickedFile!.path),
      });

      await dio.post(
        "$baseUrl/patient-reports",
        data: formData,
      );

      titleController.clear();
      hospitalController.clear();
      dateController.clear();
      reportType = null;
      pickedFile = null;
      webImage = null;

      fetchReports();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Report added successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to add report")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  /* =============================
     FETCH REPORTS
  ============================== */
  Future<void> fetchReports() async {
    try {
      final res = await dio.get(
        "$baseUrl/patient-reports/$patientId",
      );
      setState(() => reports = res.data);
    } catch (_) {}
  }

  /* =============================
     DELETE REPORT
  ============================== */
  Future<void> deleteReport(String id) async {
    await dio.delete(
      "$baseUrl/patient-reports/$id",
    );
    fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: gold,
        title: const Text("Add & Manage Reports",
            style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ADD REPORT
            Card(
              color: const Color(0xFF1C1C1C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _field("Report Title", titleController),
                      _dropdown(),
                      _field("Hospital / Lab", hospitalController),
                      _dateField(),

                      const SizedBox(height: 10),

                      /// IMAGE PICKER
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: gold.withOpacity(0.6)),
                          ),
                          child: Center(
                            child: webImage != null
                                ? Image.memory(webImage!)
                                : pickedFile != null
                                    ? Image.network(pickedFile!.path)
                                    : const Text(
                                        "Tap to upload prescription",
                                        style:
                                            TextStyle(color: Colors.white70),
                                      ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gold,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: loading ? null : addReport,
                          child: loading
                              ? const CircularProgressIndicator()
                              : const Text("ADD REPORT"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// MANAGE REPORTS
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reports.length,
              itemBuilder: (_, i) => _reportCard(reports[i]),
            ),
          ],
        ),
      ),
    );
  }

  /* =============================
     UI HELPERS
  ============================== */

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        style: const TextStyle(color: Colors.white),
        decoration: _decoration(label),
        validator: (v) => v!.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _dropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: reportType,
        dropdownColor: Colors.black,
        decoration: _decoration("Report Type"),
        items: ["Blood Test", "Scan / X-Ray", "Prescription", "Other"]
            .map((e) => DropdownMenuItem(
                  value: e,
                  child:
                      Text(e, style: const TextStyle(color: Colors.white)),
                ))
            .toList(),
        onChanged: (v) => setState(() => reportType = v),
        validator: (v) => v == null ? "Select type" : null,
      ),
    );
  }

  Widget _dateField() {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      decoration: _decoration("Report Date"),
      onTap: selectDate,
      validator: (v) => v!.isEmpty ? "Select date" : null,
    );
  }

  Widget _reportCard(report) {
    return Card(
      color: const Color(0xFF1C1C1C),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Image.network(
            "$baseUrl/uploads/${report["image"]}",
            height: 160,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(report["title"],
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(report["hospital"],
                style: const TextStyle(color: Colors.grey)),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteReport(report["_id"]),
            ),
          ),
        ],
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
          borderSide: BorderSide.none),
    );
  }
}
