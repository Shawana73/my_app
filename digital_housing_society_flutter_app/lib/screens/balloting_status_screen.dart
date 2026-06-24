import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../services/applicant_service.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import '../widgets/status_pill.dart';
import 'result_check_screen.dart';

class BallotingStatusScreen extends StatelessWidget {
  const BallotingStatusScreen({super.key});
  static const routeName = '/balloting-status';

  Map<String, dynamic> _safeMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }

  Future<Map<String, dynamic>> _load() async {
    final application = await ApplicantService.latestApplication();
    final payment = await ApplicantService.latestPayment(purpose: 'Application Fee');
    final docs = await ApplicantService.uploadedDocuments();
    return {'application': application, 'payment': payment, 'documents': docs};
  }

  Color _colorFor(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('eligible') && !lower.contains('not')) return AppColors.successGreen;
    if (lower.contains('verified') || lower.contains('approved') || lower.contains('paid')) return AppColors.successGreen;
    if (lower.contains('pending') || lower.contains('submitted') || lower.contains('uploaded')) return AppColors.warningOrange;
    if (lower.contains('not') || lower.contains('reject') || lower.contains('failed')) return AppColors.errorRed;
    return AppColors.primaryPurple;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
          const SizedBox(height: 10),
          const Text('BALLOTING\nPARTICIPATION', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.primaryText, height: 1.1)),
          const SizedBox(height: 8),
          const Text('Track eligibility, admin verification and live balloting status.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          FutureBuilder<Map<String, dynamic>>(
            future: _load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple));
              }
              final app = snapshot.data?['application'] == null ? null : _safeMap(snapshot.data?['application']);
              final pay = snapshot.data?['payment'] == null ? null : _safeMap(snapshot.data?['payment']);
              final docs = (snapshot.data?['documents'] ?? []) as List;
              final applicationStatus = app?['applicationStatus'] ?? 'Not Submitted';
              final documentsStatus = app?['documentsStatus'] ?? (docs.isEmpty ? 'Not Uploaded' : 'Uploaded - Pending Verification');
              final paymentStatus = pay?['status'] ?? app?['paymentStatus'] ?? 'Unpaid';
              final adminStatus = app?['adminVerificationStatus'] ?? 'Pending Review';
              final ballotingStatus = app?['ballotingStatus'] ?? 'Not Eligible';
              final eligible = ballotingStatus.toString().toLowerCase().contains('eligible') && !ballotingStatus.toString().toLowerCase().contains('not');

              return Column(
                children: [
                  LuxuryCard(
                    child: Column(
                      children: [
                        Icon(eligible ? Icons.verified_rounded : Icons.pending_actions_rounded, size: 64, color: eligible ? AppColors.successGreen : AppColors.primaryPurple),
                        const SizedBox(height: 12),
                        Text(eligible ? 'Eligible for Balloting' : 'Admin Verification Pending', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.primaryText), textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        Text(
                          eligible ? 'Your application, documents and payment are verified by admin.' : 'Submit application, upload documents and payment. Admin will verify before eligibility.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 18),
                        StatusPill(text: eligible ? 'ELIGIBLE' : 'PENDING VERIFICATION', color: eligible ? AppColors.successGreen : AppColors.warningOrange),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  _StatusRow(label: 'Application Status', value: applicationStatus.toString(), color: _colorFor(applicationStatus.toString())),
                  const SizedBox(height: 10),
                  _StatusRow(label: 'Documents Status', value: documentsStatus.toString(), color: _colorFor(documentsStatus.toString())),
                  const SizedBox(height: 10),
                  _StatusRow(label: 'Payment Status', value: paymentStatus.toString(), color: _colorFor(paymentStatus.toString())),
                  const SizedBox(height: 10),
                  _StatusRow(label: 'Admin Verification', value: adminStatus.toString(), color: _colorFor(adminStatus.toString())),
                  const SizedBox(height: 10),
                  _StatusRow(label: 'Balloting Eligibility', value: ballotingStatus.toString(), color: _colorFor(ballotingStatus.toString())),
                  const SizedBox(height: 10),
                  const _StatusRow(label: 'Live Balloting', value: 'Not Started', color: AppColors.primaryPurple),
                  const SizedBox(height: 24),
                  PrimaryButton(text: 'CHECK RESULT', icon: Icons.verified_rounded, onPressed: () => Navigator.pushNamed(context, ResultCheckScreen.routeName)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LuxuryCard(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline_rounded, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w900))),
          Flexible(child: StatusPill(text: value, color: color)),
        ],
      ),
    );
  }
}
