import 'package:flutter/material.dart';
import '../models/society_models.dart';
import 'applicant_verification_screen.dart';
import 'payment_verification_screen.dart';
import 'plot_management_screen.dart';
import 'balloting_screen.dart';
import 'reports_screen.dart';
import 'dealer_verification_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF), // Light Lavender Background
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildPromoCard(),
                const SizedBox(height: 28),
                _buildSectionHeader('SYSTEM OVERVIEW', () {}),
                const SizedBox(height: 16),
                _buildStatsGrid(),
                const SizedBox(height: 28),
                _buildSectionHeader('QUICK OPERATIONS', () {}),
                const SizedBox(height: 16),
                _buildQuickActionsGrid(),
                const SizedBox(height: 28),
                _buildSectionHeader('RECENT ACTIVITIES', () {}),
                const SizedBox(height: 16),
                _buildRecentActivitiesList(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Quick support system initialized.'),
              backgroundColor: Color(0xFF7B4DFF),
            ),
          );
        },
        backgroundColor: const Color(0xFF7B4DFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.bolt_outlined, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFF7B4DFF).withOpacity(0.1),
              child: const Text(
                'S',
                style: TextStyle(
                  color: Color(0xFF7B4DFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PAKISTAN SECTOR',
                  style: TextStyle(
                    color: Color(0xFF8E8EA9),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Shawon Gohar',
                  style: TextStyle(
                    color: const Color(0xFF1F1F39),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            _buildRoundIconButton(Icons.notifications_outlined, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            }),
            const SizedBox(width: 8),
            _buildRoundIconButton(Icons.logout_rounded, () {
              _showLogoutDialog();
            }, color: const Color(0xFFEF4444).withOpacity(0.08), iconColor: const Color(0xFFEF4444)),
          ],
        )
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to end your administrator session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF8E8EA9))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildRoundIconButton(IconData icon, VoidCallback onTap, {Color? color, Color? iconColor}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7B4DFF).withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(icon, color: iconColor ?? const Color(0xFF1F1F39), size: 22),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B4DFF).withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8E8EA9), size: 22),
          hintText: "Search Modern Villas, Houses, Ballots...",
          hintStyle: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildPromoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B4DFF), Color(0xFF9C6BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B4DFF).withOpacity(0.24),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -20,
            child: Icon(
              Icons.apartment_outlined,
              size: 130,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'SPECIAL OFFERS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Get Your 20% Cashback',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '*Expires 25 Aug 2026',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1F1F39),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              color: Color(0xFF7B4DFF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.45,
      children: [
        _buildStatCard('Total Applicants', '1,420', const Color(0xFF7B4DFF), Icons.people_outline),
        _buildStatCard('Total Payments', 'Rs. 842,500', const Color(0xFF22C55E), Icons.account_balance_wallet_outlined),
        _buildStatCard('Available Plots', '320 Lots', const Color(0xFFF59E0B), Icons.grid_view),
        _buildStatCard('Ballot Records', '4 Active', const Color(0xFFEF4444), Icons.ballot_outlined),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B4DFF).withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 11, fontWeight: FontWeight.bold),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F1F39),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    final List<Map<String, dynamic>> actions = [
      {'title': 'Verify Applicants', 'icon': Icons.verified_user_outlined, 'screen': const ApplicantVerificationScreen()},
      {'title': 'Verify Payments', 'icon': Icons.payment_outlined, 'screen': const PaymentVerificationScreen()},
      {'title': 'Manage Plots', 'icon': Icons.map_outlined, 'screen': const PlotManagementScreen()},
      {'title': 'Live Balloting', 'icon': Icons.settings_input_component, 'screen': const BallotingScreen()},
      {'title': 'System Reports', 'icon': Icons.assessment_outlined, 'screen': const ReportsScreen()},
      {'title': 'Verify Dealers', 'icon': Icons.handshake_outlined, 'screen': const DealerVerificationScreen()},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.92,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final act = actions[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => act['screen'] as Widget),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF7B4DFF).withOpacity(0.06)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B4DFF).withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(act['icon'] as IconData, color: const Color(0xFF7B4DFF), size: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  act['title'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Color(0xFF1F1F39),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivitiesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        final List<Map<String, String>> mockActs = [
          {'title': 'Payment Approved', 'desc': 'Txn #PAY9820 approved by Admin.', 'time': '5 mins ago', 'type': 'succ'},
          {'title': 'New Application', 'desc': 'Kabeer Raza submitted registration documents.', 'time': '12 mins ago', 'type': 'pend'},
          {'title': 'Plot Added', 'desc': 'Plot A-52 Phase 4 registered into active pool.', 'time': '1 hr ago', 'type': 'info'},
        ];
        final act = mockActs[index];
        Color badgeColor = const Color(0xFF7B4DFF);
        if (act['type'] == 'succ') badgeColor = const Color(0xFF22C55E);
        if (act['type'] == 'pend') badgeColor = const Color(0xFFF59E0B);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 40,
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      act['title']!,
                      style: const TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      act['desc']!,
                      style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                act['time']!,
                style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 10),
              )
            ],
          ),
        );
      },
    );
  }
}
