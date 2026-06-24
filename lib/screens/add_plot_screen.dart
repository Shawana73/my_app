// lib/screens/add_plot_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class AddPlotScreen extends StatefulWidget {
  const AddPlotScreen({super.key});

  @override
  State<AddPlotScreen> createState() => _AddPlotScreenState();
}
class _AddPlotScreenState extends State<AddPlotScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _sizeController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _sizeController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('ADD NEW PLOT'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PLOT UNIT DETAILS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),

              // Form fields card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _idController,
                        label: 'Plot Unit ID',
                        hint: 'e.g. PL-005',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Plot Unit ID is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _sizeController,
                        label: 'Plot Size',
                        hint: 'e.g. 5 Marla, 10 Marla, 1 Kanal',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Plot Size is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _priceController,
                        label: 'Plot Unit Price (PKR)',
                        hint: 'e.g. 3500 (in Thousands)',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Price is required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter a valid numeric price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _locationController,
                        label: 'Sector & Block Location',
                        hint: 'e.g. Sector C, DHA Phase 6',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _descController,
                        label: 'Detailed Description',
                        hint: 'Describe unique traits of this plot unit...',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Save & Reset Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                        _idController.clear();
                        _sizeController.clear();
                        _priceController.clear();
                        _locationController.clear();
                        _descController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form cleared')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primaryPurple),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Reset Form', style: TextStyle(color: AppTheme.primaryPurple, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final newPlot = Plot(
                            id: _idController.text.trim(),
                            size: _sizeController.text.trim(),
                            location: _locationController.text.trim(),
                            price: double.parse(_priceController.text.trim()),
                            status: PlotStatus.available,
                            description: _descController.text.trim().isEmpty
                                ? 'No description available'
                                : _descController.text.trim(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Plot added to registry successfully!'),
                              backgroundColor: AppTheme.success,
                            ),
                          );

                          Navigator.pop(context, newPlot);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Save Plot Unit', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.greyText),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.lightLavender,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppTheme.greyText, fontSize: 13),
              border: InputBorder.none,
              errorStyle: const TextStyle(fontSize: 10, height: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
