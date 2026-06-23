import 'package:flutter/material.dart';
import '../models/society_models.dart';

class AddPlotScreen extends StatefulWidget {
  const AddPlotScreen({Key? key}) : super(key: key);

  @override
  State<AddPlotScreen> createState() => _AddPlotScreenState();
}

class _AddPlotScreenState extends State<AddPlotScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _sizeController = TextEditingController();
  final _priceController = TextEditingController();
  final _locController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Add Plot Registry', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'REGISTER NEW PLOT UNIT',
                  style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                const SizedBox(height: 16),
                _buildFormCard(),
                const SizedBox(height: 28),
                _buildActionRow(),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildTextField('Plot ID (e.g., PL-102)', _idController, Icons.grid_3x3, (val) {
            if (val == null || val.trim().isEmpty) return 'Required';
            return null;
          }),
          const SizedBox(height: 16),
          _buildTextField('Unit Size (e.g., 5 Marla / 1 Kanal)', _sizeController, Icons.aspect_ratio, (val) {
            if (val == null || val.trim().isEmpty) return 'Required';
            return null;
          }),
          const SizedBox(height: 16),
          _buildTextField('Base Price (PKR)', _priceController, Icons.monetization_on_outlined, (val) {
            if (val == null || double.tryParse(val) == null) return 'Enter a valid price';
            return null;
          }, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildTextField('Exact Location Address', _locController, Icons.location_on_outlined, (val) {
            if (val == null || val.trim().isEmpty) return 'Required';
            return null;
          }),
          const SizedBox(height: 16),
          _buildTextField('Detailed Unit Description', _descController, Icons.article_outlined, null, maxLines: 3),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller,
      IconData icon,
      String? Function(String?)? validator, {
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFF1F1F39), fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 13),
        prefixIcon: Icon(icon, color: const Color(0xFF7B4DFF), size: 18),
        filled: true,
        fillColor: const Color(0xFFF5F3FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF7B4DFF), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final newPlot = Plot(
                  id: _idController.text.toUpperCase(),
                  size: _sizeController.text,
                  location: _locController.text,
                  price: double.parse(_priceController.text),
                  description: _descController.text.isEmpty ? "No description provided." : _descController.text,
                  status: PlotStatus.available,
                );
                Navigator.pop(context, newPlot);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Plot ${newPlot.id} logged to cloud system.'), backgroundColor: const Color(0xFF22C55E)),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B4DFF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: const Text('Publish Registry', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            _idController.clear();
            _sizeController.clear();
            _priceController.clear();
            _locController.clear();
            _descController.clear();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF8E8EA9),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            elevation: 0,
          ),
          child: const Icon(Icons.refresh),
        )
      ],
    );
  }
}
