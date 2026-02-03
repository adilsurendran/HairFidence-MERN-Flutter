import 'package:flutter/material.dart';

class DonorUpdateProfilePage extends StatefulWidget {
  const DonorUpdateProfilePage({super.key});

  @override
  State<DonorUpdateProfilePage> createState() => _DonorUpdateProfilePageState();
}

class _DonorUpdateProfilePageState extends State<DonorUpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController(text: "Arjun Menon");
  final TextEditingController emailController =
      TextEditingController(text: "arjun@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "9876543210");
  final TextEditingController addressController =
      TextEditingController(text: "Ernakulam, Kerala");
  final TextEditingController dobController =
      TextEditingController(text: "15/08/1997");
  final TextEditingController lastDonationController =
      TextEditingController(text: "20/12/2025");

  String? selectedGender = "Male";
  String? selectedBloodGroup = "O+";

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "View & Update Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF1C1C1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Color(0xFFFFC107),
                  ),
                  const SizedBox(height: 20),

                  _inputField("Full Name", Icons.person, nameController),
                  _inputField("Email", Icons.email, emailController,
                      readOnly: true),
                  _inputField("Phone", Icons.phone, phoneController),
                  _inputField("Address", Icons.location_on, addressController,
                      maxLines: 2),

                  _dropdownField(
                    label: "Gender",
                    icon: Icons.people,
                    value: selectedGender,
                    items: ["Male", "Female", "Other"],
                    onChanged: (val) => setState(() => selectedGender = val),
                  ),

                  _dateField(
                    label: "Date of Birth",
                    icon: Icons.cake,
                    controller: dobController,
                  ),

                  _dropdownField(
                    label: "Blood Group",
                    icon: Icons.bloodtype,
                    value: selectedBloodGroup,
                    items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                    onChanged: (val) =>
                        setState(() => selectedBloodGroup = val),
                  ),

                  _dateField(
                    label: "Last Donation Date",
                    icon: Icons.history,
                    controller: lastDonationController,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Profile Updated Successfully"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "UPDATE PROFILE",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
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

  /// Input Field
  Widget _inputField(
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
        readOnly: readOnly,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label, icon),
        validator: (value) =>
            value == null || value.isEmpty ? "Required field" : null,
      ),
    );
  }

  /// Dropdown Field
  Widget _dropdownField({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label, icon),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e,
                    style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  /// Date Field
  Widget _dateField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        decoration: _inputDecoration(label, icon),
        onTap: () => selectDate(context, controller),
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
