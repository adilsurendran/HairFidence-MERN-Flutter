import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hairfidence/ip_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairfidence/login.dart';

import 'Donor_manage_hair_posts_page.dart';
import 'DonorProfilePage.dart';
import 'DonorChatPage.dart';
import 'Donor_send_complaint_page.dart';
import 'Donor_view_notifications_page.dart';
import 'upcoming_campaigns_page.dart';
import 'view_my_complaints_page.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

String? ngoId;


class _DonorHomePageState extends State<DonorHomePage> {
  int currentIndex = 0;
  final Dio dio = Dio();

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;
  String? donorName; 
  /* ===========================
     LOAD DONOR DETAILS
  ============================ */
  Future<void> getDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final donorId = prefs.getString("profileId");

      final res = await dio.get("$baseUrl/donor/$donorId");
      setState(() {
        ngoId = res.data["ngoId"];
      donorName = res.data["name"];
      });
      print(res.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  /* ===========================
     LOGOUT
  ============================ */
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Loginpage()),
      (route) => false,
    );
  }

  /* ===========================
     BODY SWITCHER (KEY FIX)
  ============================ */
  Widget _getBody() {
    switch (currentIndex) {
      case 0:
        return _homeBody();

      case 1:
        return DonorManageHairPostsPage();

      case 2:
        return DonorChatPage(); // ✅ CHAT AS TAB (NO BACK BUTTON)

      case 3:
        return DonorProfilePage();

      default:
        return _homeBody();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,

      /* ===========================
         APP BAR (SAME FOR ALL TABS)
      ============================ */
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
        automaticallyImplyLeading: false, // ❌ NO BACK BUTTON
        title: Row(
          children: [
            Icon(Icons.volunteer_activism, color: gold),
            const SizedBox(width: 8),
            Text(
              "Hairfidence",
              style: TextStyle(
                color: gold,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: gold),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DonorViewNotificationsPage(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout, color: gold),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1C),
                  title: const Text("Logout",
                      style: TextStyle(color: Colors.white)),
                  content: const Text(
                    "Are you sure you want to logout?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.white70)),
                    ),
                    TextButton(
                      onPressed: logout,
                      child: Text("Logout", style: TextStyle(color: gold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      /* ===========================
         BODY
      ============================ */
      body: _getBody(),

      /* ===========================
         BOTTOM NAV BAR
      ============================ */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: "Posts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  /* ===========================
     HOME BODY
  ============================ */
  Widget _homeBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeCard(),
          const SizedBox(height: 24),
          _quickActions(),
          const SizedBox(height: 24),
          _activityCard(),
        ],
      ),
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome $donorName 👋",
            style: TextStyle(
              color: gold,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Thank you for being a part of Hairfidence.\nYour contribution changes lives.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _quickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            color: gold,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _actionCard(Icons.post_add, "Add & Manage\nPosts",
                onTap: () => setState(() => currentIndex = 1)),
            _actionCard(Icons.chat, "Chat with\nNGO",
                onTap: () => setState(() => currentIndex = 2)),
            _actionCard(Icons.report_problem, "Send\nComplaint",
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DonorSendComplaintPage()),
                    )),
            _actionCard(Icons.report_problem, "My\nComplaints",
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ViewMyComplaintsPage()),
                    )),
            _actionCard(Icons.campaign, "Campaigns",
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => UpcomingCampaignsPage()),
                    )),
          ],
        ),
      ],
    );
  }

  Widget _activityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: gold, size: 36),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "Your hair. Their confidence. Thank you 💛",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: gold, size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: gold.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: gold.withOpacity(0.15),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ],
    );
  }
}
