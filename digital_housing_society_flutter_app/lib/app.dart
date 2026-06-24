import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'screens/application_submission_screen.dart';
import 'screens/balloting_status_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/file_upload_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/plot_map_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/result_check_screen.dart';
import 'screens/splash_screen.dart';

class NoScrollbarBehavior extends MaterialScrollBehavior {
  const NoScrollbarBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class DigitalHousingSocietyApp extends StatelessWidget {
  const DigitalHousingSocietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const NoScrollbarBehavior(),
      title: 'Digital Housing Society',
      theme: AppTheme.light,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        DashboardScreen.routeName: (_) => const DashboardScreen(),
        ApplicationSubmissionScreen.routeName: (_) => const ApplicationSubmissionScreen(),
        FileUploadScreen.routeName: (_) => const FileUploadScreen(),
        PaymentScreen.routeName: (_) => const PaymentScreen(),
        BallotingStatusScreen.routeName: (_) => const BallotingStatusScreen(),
        ResultCheckScreen.routeName: (_) => const ResultCheckScreen(),
        NotificationsScreen.routeName: (_) => const NotificationsScreen(),
        PlotMapScreen.routeName: (_) => const PlotMapScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
      },
    );
  }
}
