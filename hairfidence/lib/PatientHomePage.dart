// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:hairfidence/login.dart';

// // class PatientHomePage extends StatefulWidget {
// //   const PatientHomePage({super.key});

// //   @override
// //   State<PatientHomePage> createState() => _PatientHomePageState();
// // }

// // class _PatientHomePageState extends State<PatientHomePage> {
// //   int currentIndex = 0;

// //   final Color gold = const Color(0xFFFFC107);
// //   final Color dark = Colors.black;

// //   /// ===========================
// //   /// LOGOUT
// //   /// ===========================
// //   Future<void> logout() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.clear();

// //     Navigator.pushAndRemoveUntil(
// //       context,
// //       MaterialPageRoute(builder: (_) => const Loginpage()),
// //       (route) => false,
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: dark,

// //       /* ===========================
// //          APP BAR
// //       ============================ */
// //       appBar: AppBar(
// //         backgroundColor: dark,
// //         elevation: 0,
// //         title: Row(
// //           children: [
// //             Icon(Icons.favorite, color: gold),
// //             const SizedBox(width: 8),
// //             Text(
// //               "Hairfidence",
// //               style: TextStyle(
// //                 color: gold,
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 letterSpacing: 1,
// //               ),
// //             ),
// //           ],
// //         ),
// //         actions: [
// //           /// NOTIFICATIONS
// //           IconButton(
// //             icon: Icon(Icons.notifications_none, color: gold),
// //             onPressed: () {
// //               // Navigate to notifications
// //             },
// //           ),

// //           /// LOGOUT
// //           IconButton(
// //             icon: Icon(Icons.logout, color: gold),
// //             onPressed: () {
// //               showDialog(
// //                 context: context,
// //                 builder: (_) => AlertDialog(
// //                   backgroundColor: const Color(0xFF1C1C1C),
// //                   title: const Text(
// //                     "Logout",
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                   content: const Text(
// //                     "Are you sure you want to logout?",
// //                     style: TextStyle(color: Colors.white70),
// //                   ),
// //                   actions: [
// //                     TextButton(
// //                       onPressed: () => Navigator.pop(context),
// //                       child: const Text(
// //                         "Cancel",
// //                         style: TextStyle(color: Colors.white70),
// //                       ),
// //                     ),
// //                     TextButton(
// //                       onPressed: logout,
// //                       child: Text(
// //                         "Logout",
// //                         style: TextStyle(color: gold),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ],
// //       ),

// //       /* ===========================
// //          BODY
// //       ============================ */
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             /// WELCOME CARD
// //             Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: _cardDecoration(),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     "Welcome 👋",
// //                     style: TextStyle(
// //                       color: gold,
// //                       fontSize: 22,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   const Text(
// //                     "You are not alone.\nHairfidence is here to support you.",
// //                     style: TextStyle(color: Colors.white70),
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(height: 24),

// //             /// QUICK ACTIONS
// //             Text(
// //               "Quick Actions",
// //               style: TextStyle(
// //                 color: gold,
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             const SizedBox(height: 14),

// //             GridView.count(
// //               crossAxisCount: 2,
// //               crossAxisSpacing: 14,
// //               mainAxisSpacing: 14,
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               children: [
// //                 _actionCard(
// //                   icon: Icons.add_circle_outline,
// //                   title: "Add & Manage\nMy Posts",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.campaign,
// //                   title: "View NGO\nPosts",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.assignment,
// //                   title: "Manage\nReports",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.person,
// //                   title: "Profile\nManagement",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.chat,
// //                   title: "Chat with\nNGO",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.feedback,
// //                   title: "Send\nFeedback",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.report_problem,
// //                   title: "Send\nComplaint",
// //                   onTap: () {},
// //                 ),
// //                 _actionCard(
// //                   icon: Icons.notifications,
// //                   title: "View\nNotifications",
// //                   onTap: () {},
// //                 ),
// //               ],
// //             ),

// //             const SizedBox(height: 24),

// //             /// STATUS CARD
// //             Container(
// //               padding: const EdgeInsets.all(18),
// //               decoration: _cardDecoration(),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.info_outline, color: gold, size: 34),
// //                   const SizedBox(width: 14),
// //                   const Expanded(
// //                     child: Text(
// //                       "Your latest request is under review.\nWe’ll notify you once an NGO responds.",
// //                       style: TextStyle(color: Colors.white70),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),

// //       /* ===========================
// //          BOTTOM NAV BAR
// //       ============================ */
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: currentIndex,
// //         onTap: (index) {
// //           setState(() => currentIndex = index);
// //         },
// //         backgroundColor: Colors.black,
// //         selectedItemColor: gold,
// //         unselectedItemColor: Colors.white54,
// //         type: BottomNavigationBarType.fixed,
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: "Home",
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.campaign),
// //             label: "NGO Posts",
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.post_add),
// //             label: "My Posts",
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.person),
// //             label: "Profile",
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   /* ===========================
// //      ACTION CARD
// //   ============================ */
// //   Widget _actionCard({
// //     required IconData icon,
// //     required String title,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(16),
// //         decoration: _cardDecoration(),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(icon, color: gold, size: 36),
// //             const SizedBox(height: 12),
// //             Text(
// //               title,
// //               textAlign: TextAlign.center,
// //               style: const TextStyle(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /* ===========================
// //      CARD DECORATION
// //   ============================ */
// //   BoxDecoration _cardDecoration() {
// //     return BoxDecoration(
// //       color: const Color(0xFF111111),
// //       borderRadius: BorderRadius.circular(20),
// //       border: Border.all(color: gold.withOpacity(0.4)),
// //       boxShadow: [
// //         BoxShadow(
// //           color: gold.withOpacity(0.15),
// //           blurRadius: 20,
// //           spreadRadius: 1,
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:hairfidence/ManageReport.dart';
// import 'package:hairfidence/UpdateProfile.dart';
// import 'package:hairfidence/ViewNgoPost.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hairfidence/login.dart';

// // import other patient screens


// class PatientHomePage extends StatefulWidget {
//   const PatientHomePage({super.key});

//   @override
//   State<PatientHomePage> createState() => _PatientHomePageState();
// }

// class _PatientHomePageState extends State<PatientHomePage> {
//   final int currentIndex = 0;

//   final Color gold = const Color(0xFFFFC107);
//   final Color dark = Colors.black;

//   /* ===========================
//      LOGOUT
//   ============================ */
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const Loginpage()),
//       (route) => false,
//     );
//   }

//   /* ===========================
//      BOTTOM NAVIGATION HANDLER
//   ============================ */
//   void onBottomNavTap(int index) {
//     if (index == currentIndex) return;

//     switch (index) {
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const ViewNgoPostsPage()),
//         );
//         break;

//       // case 2:
//       //   Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(builder: (_) => const PatientMyPostsPage()),
//       //   );
//       //   break;

//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const PatientProfilePage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: dark,

//       /* ===========================
//          APP BAR
//       ============================ */
//       appBar: AppBar(
//         backgroundColor: dark,
//         elevation: 0,
//         title: Row(
//           children: [
//             Icon(Icons.favorite, color: gold),
//             const SizedBox(width: 8),
//             Text(
//               "Hairfidence",
//               style: TextStyle(
//                 color: gold,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications_none, color: gold),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.logout, color: gold),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   backgroundColor: const Color(0xFF1C1C1C),
//                   title: const Text("Logout",
//                       style: TextStyle(color: Colors.white)),
//                   content: const Text(
//                     "Are you sure you want to logout?",
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text("Cancel",
//                           style: TextStyle(color: Colors.white70)),
//                     ),
//                     TextButton(
//                       onPressed: logout,
//                       child:
//                           Text("Logout", style: TextStyle(color: gold)),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),

//       /* ===========================
//          BODY
//       ============================ */
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _welcomeCard(),
//             const SizedBox(height: 24),
//             _quickActions(),
//             const SizedBox(height: 24),
//             _statusCard(),
//           ],
//         ),
//       ),

//       /* ===========================
//          BOTTOM NAV BAR
//       ============================ */
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: onBottomNavTap,
//         backgroundColor: Colors.black,
//         selectedItemColor: gold,
//         unselectedItemColor: Colors.white54,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.campaign),
//             label: "NGO Posts",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add),
//             label: "My Posts",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }

//   /* ===========================
//      UI SECTIONS
//   ============================ */

//   Widget _welcomeCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: _cardDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Welcome 👋",
//             style: TextStyle(
//               color: gold,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             "You are not alone.\nHairfidence is here to support you.",
//             style: TextStyle(color: Colors.white70),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _quickActions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Quick Actions",
//           style: TextStyle(
//             color: gold,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 14),
//         GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 14,
//           mainAxisSpacing: 14,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             _actionCard(Icons.add_circle_outline, "Add & Manage\nMy Posts", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.campaign, "View NGO\nPosts", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNgoPostsPage(),)); }),
//             _actionCard(Icons.assignment, "Manage\nReports", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.person, "Profile\nManagement", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.chat, "Chat with\nNGO", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.feedback, "Send\nFeedback", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.report_problem, "Send\nComplaint", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//             _actionCard(Icons.notifications, "View\nNotifications", onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AddManageReportPage(),)); }),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _statusCard() {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: _cardDecoration(),
//       child: Row(
//         children: [
//           Icon(Icons.info_outline, color: gold, size: 34),
//           const SizedBox(width: 14),
//           const Expanded(
//             child: Text(
//               "Your latest request is under review.\nWe’ll notify you once an NGO responds.",
//               style: TextStyle(color: Colors.white70),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//  Widget _actionCard(
//   IconData icon,
//   String title, {
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: gold, size: 36),
//           const SizedBox(height: 12),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: const Color(0xFF111111),
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(color: gold.withOpacity(0.4)),
//       boxShadow: [
//         BoxShadow(
//           color: gold.withOpacity(0.15),
//           blurRadius: 20,
//           spreadRadius: 1,
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hairfidence/AddandManagePost.dart';
import 'package:hairfidence/Feedback.dart';
import 'package:hairfidence/ManageReport.dart';
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
  const PatientHomePage({super.key});

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
        _actionCard(Icons.chat, "Chat with\nNGO", onTap: _comingSoon),
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
        child: const Text("Welcome 👋",
            style: TextStyle(color: Colors.amber, fontSize: 22)),
      );

  Widget _statusCard() => Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: const Text("Your request is under review",
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
