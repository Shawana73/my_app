import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/luxury_card.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/responsive_screen.dart';
import '../widgets/section_header.dart';
import '../widgets/status_pill.dart';
import 'application_submission_screen.dart';
import 'balloting_status_screen.dart';
import 'file_upload_screen.dart';
import 'login_screen.dart';
import 'notifications_screen.dart';
import 'payment_screen.dart';
import 'plot_map_screen.dart';
import 'profile_screen.dart';
import 'result_check_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  static const routeName = '/dashboard';

  Map<String, dynamic> _safeMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }

  Future<Map<String, dynamic>> _loadDashboard() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance;
    final profile = await db.collection('applicants').doc(uid).get();
    final app = await db.collection('applications').where('userId', isEqualTo: uid).get();
    final pay = await db.collection('payments').where('userId', isEqualTo: uid).get();
    final notes = await db.collection('notifications').where('userId', isEqualTo: uid).get();

    Map<String, dynamic>? latestFrom(QuerySnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.docs.isEmpty) return null;
      final docs = snapshot.docs.toList();
      docs.sort((a, b) {
        final at = a.data()['createdAt'];
        final bt = b.data()['createdAt'];
        final am = at is Timestamp ? at.millisecondsSinceEpoch : 0;
        final bm = bt is Timestamp ? bt.millisecondsSinceEpoch : 0;
        return bm.compareTo(am);
      });
      return {'id': docs.first.id, ...docs.first.data()};
    }

    final noteDocs = notes.docs.toList();
    noteDocs.sort((a, b) {
      final at = a.data()['createdAt'];
      final bt = b.data()['createdAt'];
      final am = at is Timestamp ? at.millisecondsSinceEpoch : 0;
      final bm = bt is Timestamp ? bt.millisecondsSinceEpoch : 0;
      return bm.compareTo(am);
    });

    return {
      'profile': profile.data() ?? {},
      'application': latestFrom(app),
      'payment': latestFrom(pay),
      'notifications': noteDocs.take(3).map((e) => e.data()).toList(),
    };
  }

  Color _statusColor(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('verified') || lower.contains('approved') || lower.contains('eligible') || lower.contains('paid') || lower.contains('selected')) return AppColors.successGreen;
    if (lower.contains('pending') || lower.contains('submitted')) return AppColors.warningOrange;
    if (lower.contains('reject') || lower.contains('failed') || lower.contains('not eligible')) return AppColors.errorRed;
    return AppColors.primaryPurple;
  }

  void _openSearchOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final maxHeight = MediaQuery.of(sheetContext).size.height * 0.78;
        return Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 26)],
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text('SEARCH & CHECK', style: TextStyle(color: AppColors.primaryText, fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Text('Choose what you want to check.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 14),
                    _SearchOption(icon: Icons.verified_rounded, title: 'Check Result by CNIC', subtitle: 'Search balloting result and plot allotment', onTap: () => Navigator.pushNamed(context, ResultCheckScreen.routeName)),
                    _SearchOption(icon: Icons.assignment_rounded, title: 'Application Status', subtitle: 'Open submitted application details', onTap: () => Navigator.pushNamed(context, ApplicationSubmissionScreen.routeName)),
                    _SearchOption(icon: Icons.payment_rounded, title: 'Payment Verification', subtitle: 'View or submit application fee', onTap: () => Navigator.pushNamed(context, PaymentScreen.routeName)),
                    _SearchOption(icon: Icons.map_rounded, title: 'Plot Map', subtitle: 'View static plot visualization', onTap: () => Navigator.pushNamed(context, PlotMapScreen.routeName)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Future.microtask(() => Navigator.pushReplacementNamed(context, LoginScreen.routeName));
    }

    return ResponsiveScreen(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
      child: FutureBuilder<Map<String, dynamic>>(
        future: _loadDashboard(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};
          final profile = _safeMap(data['profile']);
          final application = data['application'] == null ? null : _safeMap(data['application']);
          final payment = data['payment'] == null ? null : _safeMap(data['payment']);
          final notifications = (data['notifications'] ?? []) as List;

          final name = profile['fullName'] ?? user?.displayName ?? 'Applicant';
          final appStatus = application?['applicationStatus'] ?? profile['applicationStatus'] ?? 'Not Submitted';
          final docsStatus = application?['documentsStatus'] ?? profile['documentsStatus'] ?? 'Not Uploaded';
          final paymentStatus = payment?['status'] ?? profile['paymentStatus'] ?? 'Unpaid';
          final ballotStatus = application?['ballotingStatus'] ?? profile['ballotingStatus'] ?? 'Not Eligible';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.lightPurple,
                    child: Text(name.toString().trim().isEmpty ? 'A' : name.toString().trim()[0].toUpperCase(), style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PAKISTAN SECTOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primaryPurple, letterSpacing: 1)),
                        Text(name.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => Navigator.pushNamed(context, NotificationsScreen.routeName),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                  IconButton.filledTonal(
                    onPressed: () => Navigator.pushNamed(context, ProfileScreen.routeName),
                    icon: const Icon(Icons.person_outline_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              InkWell(
                onTap: () => _openSearchOptions(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 8))]),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, color: AppColors.secondaryText),
                      SizedBox(width: 10),
                      Expanded(child: Text('Search Results, Application, Payment...', style: TextStyle(color: AppColors.hintText, fontWeight: FontWeight.w700))),
                      Icon(Icons.tune_rounded, color: AppColors.primaryPurple),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 20, offset: Offset(0, 10))]),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(20)),
                            child: const Text('DIGITAL BALLOTING', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(height: 12),
                          const Text('Transparent Plot\nAllocation System', style: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w900, height: 1.2)),
                          const SizedBox(height: 6),
                          const Text('Apply • Upload • Pay • Admin Verify • Result', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    Icon(Icons.apartment_rounded, size: 84, color: Colors.white.withOpacity(0.25)),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const SectionHeader(title: 'Application Overview'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _MiniStatus(title: 'Application', value: appStatus.toString(), color: _statusColor(appStatus.toString()), onTap: () => Navigator.pushNamed(context, ApplicationSubmissionScreen.routeName))),
                  const SizedBox(width: 10),
                  Expanded(child: _MiniStatus(title: 'Payment', value: paymentStatus.toString(), color: _statusColor(paymentStatus.toString()), onTap: () => Navigator.pushNamed(context, PaymentScreen.routeName))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _MiniStatus(title: 'Documents', value: docsStatus.toString(), color: _statusColor(docsStatus.toString()), onTap: () => Navigator.pushNamed(context, FileUploadScreen.routeName))),
                  const SizedBox(width: 10),
                  Expanded(child: _MiniStatus(title: 'Balloting', value: ballotStatus.toString(), color: _statusColor(ballotStatus.toString()), onTap: () => Navigator.pushNamed(context, BallotingStatusScreen.routeName))),
                ],
              ),
              const SizedBox(height: 24),
              const SectionHeader(title: 'Quick Actions'),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.assignment_rounded, title: 'Submit Application', subtitle: 'Personal details and plot preference', onTap: () => Navigator.pushNamed(context, ApplicationSubmissionScreen.routeName)),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.cloud_upload_rounded, title: 'Upload Documents', subtitle: 'CNIC front/back and supporting file', onTap: () => Navigator.pushNamed(context, FileUploadScreen.routeName)),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.payment_rounded, title: 'Submit Payment', subtitle: 'Stripe test mode, pending admin verification', onTap: () => Navigator.pushNamed(context, PaymentScreen.routeName)),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.how_to_vote_rounded, title: 'Balloting Status', subtitle: 'Eligibility after admin approval', onTap: () => Navigator.pushNamed(context, BallotingStatusScreen.routeName)),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.verified_rounded, title: 'Check Result', subtitle: 'Check by CNIC and plot details', onTap: () => Navigator.pushNamed(context, ResultCheckScreen.routeName)),
              const SizedBox(height: 10),
              QuickActionTile(icon: Icons.map_rounded, title: 'Plot Map', subtitle: 'Static visual map of plots', onTap: () => Navigator.pushNamed(context, PlotMapScreen.routeName)),
              const SizedBox(height: 24),
              SectionHeader(title: 'Notifications Preview', actionText: 'See All', onAction: () => Navigator.pushNamed(context, NotificationsScreen.routeName)),
              const SizedBox(height: 10),
              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple))
              else if (notifications.isEmpty)
                const LuxuryCard(child: Text('No notifications yet.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)))
              else
                ...notifications.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LuxuryCard(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            const Icon(Icons.notifications_active_rounded, color: AppColors.primaryPurple),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(item['message'] ?? 'New update', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primaryText)),
                            ),
                          ],
                        ),
                      ),
                    )),
              const SizedBox(height: 18),
            ],
          );
        },
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  const _MiniStatus({required this.title, required this.value, required this.color, required this.onTap});

  final String title;
  final String value;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LuxuryCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
            child: Icon(Icons.circle, size: 14, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                StatusPill(text: value, color: color),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchOption extends StatelessWidget {
  const _SearchOption({required this.icon, required this.title, required this.subtitle, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(15)),
              child: Icon(icon, color: Colors.white, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.hintText),
          ],
        ),
      ),
    );
  }
}
