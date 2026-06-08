import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Housing Society Admin',
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    'Dashboard',
    'Applicants',
    'Balloting',
    'Payments',
    'Complaints',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FCFB),

      drawer: Drawer(
        child: Container(
          color: const Color(0xFF243C4C),
          child: Column(
            children: [
              const SizedBox(height: 60),

              CircleAvatar(
                radius: 38,
                backgroundColor: const Color(0xFF5289AD),
                child: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 38,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Admin Panel',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedIndex == index;

                    return ListTile(
                      leading: Icon(
                        getMenuIcon(index),
                        color: isSelected
                            ? Colors.white
                            : Colors.white70,
                      ),

                      title: Text(
                        menuItems[index],
                        style: GoogleFonts.poppins(
                          color: isSelected
                              ? Colors.white
                              : Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      tileColor: isSelected
                          ? const Color(0xFF5289AD)
                          : Colors.transparent,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });

                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  onPressed: () {},

                  icon: const Icon(Icons.logout),

                  label: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF4FCFB),
        iconTheme: const IconThemeData(color: Color(0xFF243C4C)),

        title: Text(
          menuItems[selectedIndex],
          style: GoogleFonts.poppins(
            color: const Color(0xFF243C4C),
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF5289AD),
              child: Text(
                'A',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Admin 👋',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF243C4C),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Manage applicants, balloting, payments and housing records.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF698696),
              ),
            ),

            const SizedBox(height: 28),

            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1.1,
              children: [
                buildDashboardCard(
                  title: 'Total Applicants',
                  value: '1,250',
                  icon: Icons.people_alt_outlined,
                ),
                buildDashboardCard(
                  title: 'Approved Files',
                  value: '980',
                  icon: Icons.verified_outlined,
                ),
                buildDashboardCard(
                  title: 'Pending Payments',
                  value: '145',
                  icon: Icons.payment_outlined,
                ),
                buildDashboardCard(
                  title: 'Complaints',
                  value: '32',
                  icon: Icons.report_problem_outlined,
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              'Recent Applicants',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF243C4C),
              ),
            ),

            const SizedBox(height: 16),

            buildApplicantTile(
              name: 'Ali Raza',
              cnic: '35201-1234567-1',
              status: 'Approved',
            ),

            buildApplicantTile(
              name: 'Sara Khan',
              cnic: '35201-9876543-2',
              status: 'Pending',
            ),

            buildApplicantTile(
              name: 'Usman Tariq',
              cnic: '35201-1122334-5',
              status: 'Rejected',
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF243C4C),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5289AD),
                            minimumSize: const Size(0, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          onPressed: () {},

                          icon: const Icon(Icons.add),

                          label: Text(
                            'Add Plot',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF243C4C),
                            minimumSize: const Size(0, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          onPressed: () {},

                          icon: const Icon(Icons.list_alt),

                          label: Text(
                            'View Reports',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEAF3F8),
            child: Icon(
              icon,
              color: const Color(0xFF5289AD),
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF243C4C),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF698696),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildApplicantTile({
    required String name,
    required String cnic,
    required String status,
  }) {
    Color statusColor;

    if (status == 'Approved') {
      statusColor = Colors.green;
    } else if (status == 'Pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: const Color(0xFFEAF3F8),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFF5289AD),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xFF243C4C),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  cnic,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF698696),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              status,
              style: GoogleFonts.poppins(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData getMenuIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard_outlined;
      case 1:
        return Icons.people_outline;
      case 2:
        return Icons.how_to_vote_outlined;
      case 3:
        return Icons.payments_outlined;
      case 4:
        return Icons.report_problem_outlined;
      case 5:
        return Icons.settings_outlined;
      default:
        return Icons.dashboard;
    }
  }
}