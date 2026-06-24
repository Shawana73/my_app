import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/validators.dart';
import '../services/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.login(email: _email.text.trim(), password: _password.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      useGradientBackground: true,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 36),
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 18)]),
              child: const Icon(Icons.diamond_rounded, color: AppColors.primaryPurple, size: 32),
            ),
            const SizedBox(height: 22),
            const Text('WELCOME BACK', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
            const SizedBox(height: 6),
            const Text('Sign in to your luxury account', style: TextStyle(fontSize: 14, color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
            const SizedBox(height: 76),
            LuxuryCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppTextField(
                    label: 'Email Address',
                    controller: _email,
                    hintText: 'shawan@gmail.com',
                    prefixIcon: Icons.alternate_email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    label: 'Secret Password',
                    controller: _password,
                    hintText: '••••••••••',
                    prefixIcon: Icons.star_rounded,
                    obscureText: _obscure,
                    validator: (v) => Validators.requiredText(v, 'Password'),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: AppColors.secondaryText),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: const Text('Forgot password?', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w700))),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(text: 'SIGN IN NOW', loading: _loading, onPressed: _login),
                ],
              ),
            ),
            const SizedBox(height: 78),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to the Society? ', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, RegisterScreen.routeName),
                  child: const Text('Create Account', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
