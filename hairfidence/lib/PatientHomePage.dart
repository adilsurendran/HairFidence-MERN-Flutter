import 'package:flutter/material.dart';
import 'package:hairfidence/Feedback.dart';
import 'package:hairfidence/ManageReport.dart';
import 'package:hairfidence/PatientChatListPage.dart';
import 'package:hairfidence/UpdateProfile.dart';
import 'package:hairfidence/ViewNgoPost.dart';
import 'package:hairfidence/ViewNotification.dart';
import 'package:hairfidence/patient_manage_posts_page.dart';
import 'package:hairfidence/send_complaint_page.dart';
import 'package:hairfidence/upcoming_campaigns_page.dart';
import 'package:hairfidence/view_my_complaints_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairfidence/login.dart';

class PatientHomePage extends StatefulWidget {
  final String patientname;
  const PatientHomePage({super.key,required this.patientname});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int currentIndex = 0;

  final Color gold = const Color(0xFFFFC107);
  final Color dark = Colors.black;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      _homeUI(),
      const ViewNgoPostsPage(),
      const PatientManagePostsPage(),
      const PatientProfilePage(),
    ];
  }

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

      appBar: _buildAppBar(),

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        backgroundColor: Colors.black,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: "NGO Posts"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "My Posts"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: dark,
      elevation: 0,
      title: Row(
        children: [
          Icon(Icons.favorite, color: gold),
          const SizedBox(width: 8),
          Text(
            "Hairfidence",
            style: TextStyle(color: gold, fontSize: 22),
          ),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.notifications_none, color: gold),
            onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNotificationsPage(),))),
        IconButton(
          icon: Icon(Icons.logout, color: gold),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: const Color(0xFF1C1C1C),
                title:
                    const Text("Logout", style: TextStyle(color: Colors.white)),
                content: const Text("Are you sure?",
                    style: TextStyle(color: Colors.white70)),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel")),
                  TextButton(onPressed: logout, child: const Text("Logout")),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _homeUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeCard(),
          const SizedBox(height: 24),
          _quickActions(),
          const SizedBox(height: 24),
          _statusCard(),
        ],
      ),
    );
  }

  Widget _quickActions() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _actionCard(Icons.add_circle_outline, "Add & Manage\nMy Posts",
            onTap: () => setState(() => currentIndex = 2)),
        _actionCard(Icons.campaign, "View NGO\nPosts",
            onTap: () => setState(() => currentIndex = 1)),
        _actionCard(Icons.assignment, "Manage\nReports",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),))),
            _actionCard(Icons.assignment, "View\n Campaigns",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingCampaignsPage(),))),
        _actionCard(Icons.person, "Profile\nManagement",
            onTap: () => setState(() => currentIndex = 3)),
        _actionCard(Icons.chat, "Chat with\nNGO", onTap:  ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => PatientChatListPage(),))),
        _actionCard(Icons.feedback, "Send\nFeedback", onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SendFeedbackPage(),))),
        _actionCard(Icons.report_problem, "Send\nComplaint", onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => SendComplaintPage(),))),
        _actionCard(Icons.report_problem, "View my \nComplaint", onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMyComplaintsPage(),))),
        _actionCard(Icons.notifications, "View\nNotifications",
            onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNotificationsPage(),))),
      ],
    );
  }

  Widget _welcomeCard() => Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child:  Text("Welcome ${widget.patientname}👋",
            style: TextStyle(color: Colors.amber, fontSize: 22)),
      );

  Widget _statusCard() => Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: const Text("Someone cared. Now it’s your turn to shine 💛",
            style: TextStyle(color: Colors.white70)),
      );

  Widget _actionCard(IconData icon, String title,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _cardDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: gold),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _comingSoon() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Coming Soon")));
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: gold.withOpacity(.4)),
    );
  }
}
