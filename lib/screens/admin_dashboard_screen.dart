// lib/screens/admin_dashboard_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import 'applicant_verification_screen.dart';
import 'payment_verification_screen.dart';
import 'plot_management_screen.dart';
import 'balloting_screen.dart';
import 'reports_screen.dart';
import 'dealer_verification_screen.dart';
import 'notification_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.secondaryPurple.withOpacity(0.2),
              child: const Text(
                'SG',
                style: TextStyle(
                  color: AppTheme.primaryPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'DIRECTOR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'Shawon Gohar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkText,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, size: 28),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.rejected,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logging out Shawon Gohar...')),
              );
            },
            icon: const Icon(Icons.logout, color: AppTheme.rejected),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlotManagementScreen()),
          );
        },
        backgroundColor: AppTheme.primaryPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppTheme.softShadows,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: AppTheme.greyText),
                  hintText: 'Search Modern Villas, Houses...',
                  hintStyle: TextStyle(color: AppTheme.greyText),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Promo Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryPurple, AppTheme.secondaryPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppTheme.borderRadius,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'SPECIAL OFFER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Get Your 20% Cashback',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '*Expires 25 Aug 2026',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.home, size: 64, color: Colors.white24),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // System Overview Title
            const Text(
              'SYSTEM OVERVIEW',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            // Statistics Grid (2x2)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard(context, 'Total Applicants', '4', AppTheme.primaryPurple),
                _buildStatCard(context, 'Total Payments', 'Rs. 42,000.5', AppTheme.success),
                _buildStatCard(context, 'Plots Available', '2 Lots', AppTheme.warning),
                _buildStatCard(context, 'Allocated Lots', '1 Lots', AppTheme.secondaryPurple),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Operations Title
            const Text(
              'QUICK OPERATIONS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),

            // Quick Operations Grid (2x3 or 3x2)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.95,
              children: [
                _buildQuickAction(
                  context,
                  Icons.people_alt_outlined,
                  'Verify Applicants',
                  const ApplicantVerificationScreen(),
                ),
                _buildQuickAction(
                  context,
                  Icons.payment_outlined,
                  'Verify Payments',
                  const PaymentVerificationScreen(),
                ),
                _buildQuickAction(
                  context,
                  Icons.layers_outlined,
                  'Manage Plots',
                  const PlotManagementScreen(),
                ),
                _buildQuickAction(
                  context,
                  Icons.auto_awesome,
                  'Live Balloting',
                  const BallotingScreen(),
                ),
                _buildQuickAction(
                  context,
                  Icons.analytics_outlined,
                  'Reports Hub',
                  const ReportsScreen(),
                ),
                _buildQuickAction(
                  context,
                  Icons.verified_user_outlined,
                  'Verify Dealers',
                  const DealerVerificationScreen(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Application Trend Block
            Card(
              shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadius),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Application Trend',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkText,
                              ),
                            ),
                            Text(
                              'Jan - Jun 2024',
                              style: TextStyle(fontSize: 12, color: AppTheme.greyText),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildLegendIndicator('Applications', AppTheme.primaryPurple),
                            const SizedBox(width: 8),
                            _buildLegendIndicator('Verified', AppTheme.success),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Mock Trend Visualization
                    SizedBox(
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildTrendBar('Jan', 45, 15),
                          _buildTrendBar('Feb', 80, 45),
                          _buildTrendBar('Mar', 110, 75),
                          _buildTrendBar('Apr', 90, 60),
                          _buildTrendBar('May', 145, 110),
                          _buildTrendBar('Jun', 180, 160),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String val, Color col) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadius,
        boxShadow: AppTheme.softShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.greyText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            val,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: col,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Widget targetScreen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.softShadows,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryPurple.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryPurple, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppTheme.greyText),
        ),
      ],
    );
  }

  Widget _buildTrendBar(String label, double val, double verifiedVal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 8,
              height: val * 0.5,
              decoration: const BoxDecoration(
                color: AppTheme.primaryPurple,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: 8,
              height: verifiedVal * 0.5,
              decoration: const BoxDecoration(
                color: AppTheme.success,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.greyText)),
      ],
    );
  }
}