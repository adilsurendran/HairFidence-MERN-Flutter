import 'package:flutter/material.dart';

class ViewDonorPage extends StatelessWidget {
  const ViewDonorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "View Donors",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFC107),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _donorCard(
            name: "Rahul Kumar",
            bloodGroup: "O+",
            gender: "Male",
            age: "25",
            location: "Kochi",
            lastDonation: "12-10-2025",
          ),
          _donorCard(
            name: "Anjali Sharma",
            bloodGroup: "A-",
            gender: "Female",
            age: "28",
            location: "Trivandrum",
            lastDonation: "05-09-2025",
          ),
          _donorCard(
            name: "Mohammed Ali",
            bloodGroup: "B+",
            gender: "Male",
            age: "32",
            location: "Calicut",
            lastDonation: "22-08-2025",
          ),
          _donorCard(
            name: "Sneha Nair",
            bloodGroup: "AB+",
            gender: "Female",
            age: "26",
            location: "Thrissur",
            lastDonation: "15-07-2025",
          ),
        ],
      ),
    );
  }

  Widget _donorCard({
    required String name,
    required String bloodGroup,
    required String gender,
    required String age,
    required String location,
    required String lastDonation,
  }) {
    return Card(
      color: const Color(0xFF1C1C1C),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    bloodGroup,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(Icons.person, "Gender", gender),
            _infoRow(Icons.cake, "Age", age),
            _infoRow(Icons.location_on, "Location", location),
            _infoRow(Icons.history, "Last Donation", lastDonation),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFFC107), size: 20),
          const SizedBox(width: 10),
          Text(
            "$title : ",
            style: const TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
