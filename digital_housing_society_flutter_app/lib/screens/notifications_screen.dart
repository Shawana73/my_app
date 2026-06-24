import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/luxury_card.dart';
import '../widgets/responsive_screen.dart';
import 'application_submission_screen.dart';
import 'balloting_status_screen.dart';
import 'file_upload_screen.dart';
import 'payment_screen.dart';
import 'result_check_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  static const routeName = '/notifications';

  void _openAction(BuildContext context, Map<String, dynamic> item) {
    final route = item['actionRoute']?.toString();
    final fallbackType = item['type']?.toString().toLowerCase() ?? '';
    String? target = route;

    target ??= fallbackType.contains('payment')
        ? PaymentScreen.routeName
        : fallbackType.contains('upload')
            ? FileUploadScreen.routeName
            : fallbackType.contains('application')
                ? ApplicationSubmissionScreen.routeName
                : fallbackType.contains('result')
                    ? ResultCheckScreen.routeName
                    : BallotingStatusScreen.routeName;

    Navigator.pushNamed(context, target);
  }

  IconData _iconFor(String type) {
    final lower = type.toLowerCase();
    if (lower.contains('payment')) return Icons.payment_rounded;
    if (lower.contains('upload')) return Icons.cloud_done_rounded;
    if (lower.contains('application')) return Icons.assignment_turned_in_rounded;
    if (lower.contains('result')) return Icons.emoji_events_rounded;
    return Icons.notifications_active_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return ResponsiveScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
              const SizedBox(width: 8),
              const Text('NOTIFICATIONS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Application, document, payment and balloting updates will appear here.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('notifications').where('userId', isEqualTo: uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
              }
              final docs = snapshot.data?.docs.toList() ?? [];
              docs.sort((a, b) {
                final at = a.data()['createdAt'];
                final bt = b.data()['createdAt'];
                final am = at is Timestamp ? at.millisecondsSinceEpoch : 0;
                final bm = bt is Timestamp ? bt.millisecondsSinceEpoch : 0;
                return bm.compareTo(am);
              });
              if (docs.isEmpty) {
                return const LuxuryCard(child: Center(child: Text('No notifications available yet. Submit application/payment to generate updates.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w800), textAlign: TextAlign.center)));
              }
              return Column(
                children: docs.map((doc) {
                  final item = doc.data();
                  final type = item['type']?.toString() ?? 'General';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: LuxuryCard(
                      onTap: () => _openAction(context, item),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(15)),
                            child: Icon(_iconFor(type), color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['title'] ?? 'Update', style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primaryText)),
                                const SizedBox(height: 6),
                                Text(item['message'] ?? 'New update received.', style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, height: 1.35)),
                                const SizedBox(height: 8),
                                const Text('Tap to open', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900, fontSize: 12)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: AppColors.hintText),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
