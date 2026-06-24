import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/responsive_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, isLoggedIn ? DashboardScreen.routeName : LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      useGradientBackground: true,
      scrollable: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 10))],
            ),
            child: Center(
              child: Transform.rotate(
                angle: 0.78,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.gradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'DIGITAL HOUSING',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: AppColors.primaryText, letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          const Text(
            'SMART • SECURE • TRANSPARENT',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.primaryPurple, letterSpacing: 4),
          ),
          const SizedBox(height: 46),
          const Text(
            'Premium Living\nElevated.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: AppColors.primaryText, height: 1.25),
          ),
          const SizedBox(height: 18),
          const Text(
            'Experience the future of real estate management\nwith high-end luxury at your fingertips.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w600, height: 1.45),
          ),
          const SizedBox(height: 26),
          Container(width: 56, height: 3, decoration: BoxDecoration(gradient: AppColors.gradient, borderRadius: BorderRadius.circular(30))),
          const Spacer(),
          const SizedBox(
            width: 38,
            height: 38,
            child: CircularProgressIndicator(color: AppColors.primaryPurple, strokeWidth: 3),
          ),
          const SizedBox(height: 16),
          const Text(
            'LOADING SUITE...',
            style: TextStyle(fontSize: 11, letterSpacing: 2.4, color: AppColors.secondaryText, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
