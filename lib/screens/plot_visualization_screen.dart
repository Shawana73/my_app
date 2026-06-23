import 'package:flutter/material.dart';

class PlotVisualizationScreen extends StatelessWidget {
  const PlotVisualizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Plot Space Map', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildLegendCard(),
            const SizedBox(height: 18),
            _buildInteractiveMapMock(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendCol('Available', const Color(0xFF22C55E)),
          _buildLegendCol('Booked Unit', const Color(0xFFF59E0B)),
          _buildLegendCol('Allocated', const Color(0xFF7B4DFF)),
        ],
      ),
    );
  }

  Widget _buildLegendCol(String name, Color c) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(name, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8EA9), fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInteractiveMapMock(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Text('SECTOR ALPHA - GEOGRAPHICAL UNIT MATRIX', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39), fontSize: 11)),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 16,
            itemBuilder: (context, index) {
              Color blockColor = const Color(0xFF22C55E);
              String title = 'A-${index + 1}';
              if (index % 3 == 1) blockColor = const Color(0xFFF59E0B);
              if (index % 5 == 2) blockColor = const Color(0xFF7B4DFF);

              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unit ${title} Details Loaded.')));
                },
                child: Container(
                  decoration: BoxDecoration(color: blockColor.withOpacity(0.12), border: Border.all(color: blockColor, width: 1.5), borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: blockColor))),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.zoom_in, color: Color(0xFF7B4DFF)),
              SizedBox(width: 8),
              Text('Pinch / Zoom Map Representation Enabled', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }
}
