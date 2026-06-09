import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Check login state
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(DigitalHousingSocietyApp(isLoggedIn: isLoggedIn));
}

class DigitalHousingSocietyApp extends StatelessWidget {
  final bool isLoggedIn;
  const DigitalHousingSocietyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Housing Society',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: SplashScreen(isLoggedIn: isLoggedIn),
    );
  }
}