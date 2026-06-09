import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/step_indicator.dart';
import 'registration_step2_screen.dart';

class RegistrationStep1Screen extends StatefulWidget {
  const RegistrationStep1Screen({super.key});

  @override
  State<RegistrationStep1Screen> createState() =>
      _RegistrationStep1ScreenState();
}

class _RegistrationStep1ScreenState
    extends State<RegistrationStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _cnicCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cnicCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep2Screen(
          fullName: _nameCtrl.text,
          email: _emailCtrl.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: AppTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Apply for Plot Balloting'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppTheme.divider),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Complete your registration in 3 simple steps',
                  style: AppTheme.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const StepIndicator(currentStep: 1),
                const SizedBox(height: 24),
                _buildFormCard(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: AppTheme.primaryButtonStyle(),
                    child: const Text('Next — Plot Details',
                        style: AppTheme.buttonText),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Already have an account? Login here',
                      style: TextStyle(
                          color: AppTheme.primary, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(radius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_outline,
                    color: AppTheme.primary, size: 18),
              ),
              const SizedBox(width: 10),
              const Text('Personal Information',
                  style: AppTheme.heading3),
            ],
          ),
          const SizedBox(height: 20),
          _label('Full Name'),
          TextFormField(
            controller: _nameCtrl,
            textCapitalization: TextCapitalization.words,
            decoration: AppTheme.inputDecoration(
              label: '', hint: 'Muhammad Ahmed Khan',
              prefixIcon: Icons.person_outline,
            ),
            validator: (v) =>
            (v == null || v.trim().isEmpty) ? 'Name is required' : null,
          ),
          const SizedBox(height: 16),
          _label('CNIC Number'),
          TextFormField(
            controller: _cnicCtrl,
            keyboardType: TextInputType.number,
            decoration: AppTheme.inputDecoration(
              label: '', hint: '35201-1234567-8',
              prefixIcon: Icons.credit_card_outlined,
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'CNIC is required';
              if (!RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(v)) {
                return 'Format: 35201-1234567-8';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _label('Phone Number'),
          TextFormField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: AppTheme.inputDecoration(
              label: '', hint: '+92 300 1234567',
              prefixIcon: Icons.phone_outlined,
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Phone is required';
              if (!RegExp(r'^\+92\s?\d{3}\s?\d{7}$').hasMatch(v)) {
                return 'Format: +92 300 1234567';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _label('Email Address'),
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: AppTheme.inputDecoration(
              label: '', hint: 'ahmed@example.com',
              prefixIcon: Icons.email_outlined,
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w.-]+@[\w.-]+\.\w+$').hasMatch(v)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _label('Address'),
          TextFormField(
            controller: _addressCtrl,
            maxLines: 3,
            decoration: AppTheme.inputDecoration(
              label: '', hint: 'House No., Street, City',
              prefixIcon: Icons.location_on_outlined,
            ),
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Address is required'
                : null,
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          )),
    );
  }
}