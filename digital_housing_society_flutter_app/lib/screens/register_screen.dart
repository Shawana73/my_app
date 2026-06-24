import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/validators.dart';
import '../services/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _cnic = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    _cnic.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await AuthService.registerApplicant(
        fullName: _fullName.text.trim(),
        email: _email.text.trim(),
        phone: _phone.text.trim(),
        cnic: _cnic.text.trim(),
        password: _password.text,
      );
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
            const SizedBox(height: 18),
            const Text('CREATE ACCOUNT', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
            const SizedBox(height: 6),
            const Text('Join Digital Housing Society in minutes', style: TextStyle(fontSize: 14, color: AppColors.primaryText, fontWeight: FontWeight.w700)),
            const SizedBox(height: 36),
            LuxuryCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AppTextField(label: 'Full Name', controller: _fullName, hintText: 'e.g. Shawan Gohar', validator: (v) => Validators.requiredText(v, 'Full name')),
                  const SizedBox(height: 16),
                  AppTextField(label: 'Email Address', controller: _email, hintText: 'shawan@gmail.com', keyboardType: TextInputType.emailAddress, validator: Validators.email),
                  const SizedBox(height: 16),
                  AppTextField(label: 'Phone (Pakistan)', controller: _phone, hintText: '03001234567', keyboardType: TextInputType.phone, validator: Validators.phone),
                  const SizedBox(height: 16),
                  AppTextField(label: 'CNIC (National ID)', controller: _cnic, hintText: '42101-1234567-1', keyboardType: TextInputType.number, validator: Validators.cnic),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Strong Password',
                    controller: _password,
                    hintText: r'8+ chars, Capital, Number, $',
                    obscureText: _obscure,
                    validator: Validators.strongPassword,
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded, color: AppColors.primaryText),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Confirm Password',
                    controller: _confirm,
                    hintText: 'Verify password',
                    obscureText: true,
                    validator: (v) => v == _password.text ? null : 'Passwords do not match',
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(text: 'CREATE ACCOUNT', loading: _loading, onPressed: _register),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already a Member? ', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                  child: const Text('Login Now', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
