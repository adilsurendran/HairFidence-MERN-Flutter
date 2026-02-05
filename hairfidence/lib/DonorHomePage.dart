import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hairfidence/DonorProfilePage.dart';
import 'package:hairfidence/DonorRegister.dart';
import 'package:hairfidence/Donor_manage_hair_posts_page.dart';
import 'package:hairfidence/Donor_send_complaint_page.dart';
import 'package:hairfidence/Donor_view_notifications_page.dart';
import 'package:hairfidence/upcoming_campaigns_page.dart';
import 'package:hairfidence/view_my_complaints_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairfidence/login.dart';

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

  Future <void> getdetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
    final donorId = prefs.getString("profileId");
      final res = await dio.get("$baseUrl/donor/$donorId");
      ngoId=res.data["ngoId"];
      print(ngoId);
    } catch (e) {
      print(e);
    }
  }
    @override
  void initState() {
    super.initState();
    getdetails();
  }
  /// ===========================
  /// LOGOUT
  /// ===========================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Loginpage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,

      /* ===========================
         APP BAR
      ============================ */
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 0,
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
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        actions: [
          /// NOTIFICATIONS
          IconButton(
            icon: Icon(Icons.notifications_none, color: gold),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorViewNotificationsPage(),)),
          ),

          /// LOGOUT
          IconButton(
            icon: Icon(Icons.logout, color: gold),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1C),
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    "Are you sure you want to logout?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: logout,
                      child: Text(
                        "Logout",
                        style: TextStyle(color: gold),
                      ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// WELCOME CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Donor 👋",
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
            ),

            const SizedBox(height: 24),

            /// QUICK ACTIONS
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
                _actionCard(
                  icon: Icons.post_add,
                  title: "Add & Manage\nPosts",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorManageHairPostsPage(),)),
                
                ),
                // _actionCard(
                //   icon: Icons.history,
                //   title: "Donation\nHistory",
                //   onTap: () {},
                // ),
                _actionCard(
                  icon: Icons.person,
                  title: "My\nProfile",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorProfilePage(),)),
                ),
                _actionCard(
                  icon: Icons.notifications,
                  title: "View\nNotifications",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorViewNotificationsPage(),)),
                ),
                _actionCard(
                  icon: Icons.chat,
                  title: "Chat with\nNGO",
                  onTap: () {},
                ),
                _actionCard(
                  icon: Icons.report_problem,
                  title: "Send a \n Complaints",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DonorSendComplaintPage(),)),
                ),
                _actionCard(
                  icon: Icons.report_problem,
                  title: "My Complaints",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMyComplaintsPage(),)),
                ),
                _actionCard(
                  icon: Icons.report_problem,
                  title: "Campaigns",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingCampaignsPage(),)),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ACTIVITY CARD
            Container(
              padding: const EdgeInsets.all(18),
              decoration: _cardDecoration(),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: gold, size: 36),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      "You have successfully completed 3 donations.\nKeep spreading confidence 💛",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /* ===========================
         BOTTOM NAV BAR
      ============================ */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.history),
          //   label: "History",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  /* ===========================
     ACTION CARD
  ============================ */
  Widget _actionCard({
    required IconData icon,
    required String title,
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

  /* ===========================
     CARD DECORATION
  ============================ */
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
