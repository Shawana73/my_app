import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return ResponsiveScreen(
      child: FutureBuilder(
        future: AuthService.profile(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data() ?? {};
          final name = data['fullName'] ?? user.displayName ?? 'Applicant';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
              const SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(radius: 48, backgroundColor: AppColors.lightPurple, child: Text(name.toString().trim().isEmpty ? 'A' : name.toString().trim()[0].toUpperCase(), style: const TextStyle(fontSize: 34, color: AppColors.primaryPurple, fontWeight: FontWeight.w900))),
                    const SizedBox(height: 14),
                    Text(name.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
                    Text(user.email ?? '', style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              LuxuryCard(child: Column(children: [
                _Line(label: 'CNIC', value: data['cnic'] ?? 'Not set'),
                _Line(label: 'Phone', value: data['phone'] ?? 'Not set'),
                _Line(label: 'Application', value: data['applicationStatus'] ?? 'Not Submitted'),
                _Line(label: 'Payment', value: data['paymentStatus'] ?? 'Unpaid'),
              ])),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'LOGOUT',
                icon: Icons.logout_rounded,
                onPressed: () async {
                  await AuthService.logout();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (_) => false);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});
  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w800))),
          Flexible(child: Text(value.toString(), textAlign: TextAlign.right, style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }
}
