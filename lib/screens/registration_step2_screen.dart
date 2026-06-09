import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/step_indicator.dart';
import 'registration_step3_screen.dart';

class RegistrationStep2Screen extends StatefulWidget {
  final String fullName;
  final String email;
  const RegistrationStep2Screen({
    super.key,
    required this.fullName,
    required this.email,
  });

  @override
  State<RegistrationStep2Screen> createState() =>
      _RegistrationStep2ScreenState();
}

class _RegistrationStep2ScreenState
    extends State<RegistrationStep2Screen> {
  int _selectedPlot = 0;
  bool _cnicUploaded = false;

  final _plots = [
    _PlotOption('5-Marla', 'PKR 25 Lakh', '5M'),
    _PlotOption('10-Marla', 'PKR 45 Lakh', '10M'),
    _PlotOption('1-Kanal', 'PKR 85 Lakh', '1K'),
  ];

  void _continue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationStep3Screen(
          fullName: widget.fullName,
          email: widget.email,
          plotCategory: _plots[_selectedPlot].name,
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
          child: Column(
            children: [
              const Text(
                'Complete your registration in 3 simple steps',
                style: AppTheme.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const StepIndicator(currentStep: 2),
              const SizedBox(height: 24),
              _buildPlotCard(),
              const SizedBox(height: 16),
              _buildDocumentCard(),
              const SizedBox(height: 16),
              _buildUploadCard(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: AppTheme.outlineButtonStyle(),
                      child: const Text('Back',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          )),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: AppTheme.primaryButtonStyle(),
                      child: const Text('Continue',
                          style: AppTheme.buttonText),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
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
    );
  }

  Widget _buildPlotCard() {
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
                child: const Icon(Icons.grid_view_rounded,
                    color: AppTheme.primary, size: 18),
              ),
              const SizedBox(width: 10),
              const Text('Plot Selection', style: AppTheme.heading3),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Plot Category', style: AppTheme.bodySecondary),
          const SizedBox(height: 12),
          Row(
            children: List.generate(_plots.length, (i) {
              final isSelected = i == _selectedPlot;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPlot = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primary.withOpacity(0.08)
                          : AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.divider,
                        width: isSelected ? 2 : 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _plots[i].name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? AppTheme.primary
                                : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _plots[i].price,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? AppTheme.primary
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline,
                  color: AppTheme.primary, size: 18),
              const SizedBox(width: 8),
              const Text('Document Requirements',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          ...[
            'CNIC (Front & Back)',
            '2 Passport Size Photos',
            'Proof of Income',
          ].map((doc) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.circle,
                    size: 6, color: AppTheme.primary),
                const SizedBox(width: 8),
                Text(doc,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textPrimary,
                    )),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(radius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upload CNIC Copy',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              )),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _cnicUploaded = !_cnicUploaded),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: _cnicUploaded
                    ? AppTheme.success.withOpacity(0.08)
                    : AppTheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _cnicUploaded
                      ? AppTheme.success
                      : AppTheme.divider,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _cnicUploaded
                        ? Icons.check_circle_rounded
                        : Icons.upload_rounded,
                    color: _cnicUploaded
                        ? AppTheme.success
                        : AppTheme.textSecondary,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _cnicUploaded
                        ? 'CNIC Uploaded Successfully'
                        : 'Click to upload or drag and drop',
                    style: TextStyle(
                      color: _cnicUploaded
                          ? AppTheme.success
                          : AppTheme.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (!_cnicUploaded)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'PDF, JPG or PNG (max. 5MB)',
                        style: AppTheme.caption,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlotOption {
  final String name;
  final String price;
  final String code;
  const _PlotOption(this.name, this.price, this.code);
}