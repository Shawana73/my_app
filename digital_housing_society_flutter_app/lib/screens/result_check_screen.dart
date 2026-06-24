import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/validators.dart';
import '../services/result_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'result_display_screen.dart';

class ResultCheckScreen extends StatefulWidget {
  const ResultCheckScreen({super.key});
  static const routeName = '/result-check';

  @override
  State<ResultCheckScreen> createState() => _ResultCheckScreenState();
}

class _ResultCheckScreenState extends State<ResultCheckScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cnic = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _cnic.dispose();
    super.dispose();
  }

  Future<void> _check() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final result = await ResultService.findResultByCnic(_cnic.text.trim());
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => ResultDisplayScreen(cnic: _cnic.text.trim(), result: result)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
            const SizedBox(height: 46),
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 20)]),
                child: const Icon(Icons.verified_user_rounded, color: AppColors.primaryPurple, size: 38),
              ),
            ),
            const SizedBox(height: 24),
            const Center(child: Text('CHECK RESULT', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.primaryText))),
            const SizedBox(height: 8),
            const Center(child: Text('Enter CNIC to view balloting result', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700))),
            const SizedBox(height: 46),
            LuxuryCard(
              child: Column(
                children: [
                  AppTextField(label: 'CNIC Number', controller: _cnic, hintText: '42101-1234567-1', validator: Validators.cnic, prefixIcon: Icons.badge_rounded),
                  const SizedBox(height: 24),
                  PrimaryButton(text: 'CHECK RESULT', icon: Icons.search_rounded, loading: _loading, onPressed: _check),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
