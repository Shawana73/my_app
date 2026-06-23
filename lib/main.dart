import 'package:flutter/material.dart';
import 'screens/admin_dashboard_screen.dart';

void main() {
  runApp(const DigitalHousingApp());
}

class DigitalHousingApp extends StatelessWidget {
  const DigitalHousingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Housing Society Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF7B4DFF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B4DFF),
          primary: const Color(0xFF7B4DFF),
          secondary: const Color(0xFF9C6BFF),
          background: const Color(0xFFF5F3FF),
        ),
        fontFamily: 'Inter',
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: const Color(0xFF7B4DFF).withOpacity(0.04),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
      ),
      home: const AdminDashboardScreen(),
    );
  }
}
