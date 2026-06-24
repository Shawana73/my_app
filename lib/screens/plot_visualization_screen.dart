// lib/screens/plot_visualization_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';

class PlotVisualizationScreen extends StatefulWidget {
  const PlotVisualizationScreen({super.key});

  @override
  State<PlotVisualizationScreen> createState() => _PlotVisualizationScreenState();
}

class _PlotVisualizationScreenState extends State<PlotVisualizationScreen> {
  // Sector Matrix Map Data matching layout in mockups
  final List<Map<String, dynamic>> _matrixPlots = [
    {'id': 'A-1', 'status': 'READY'},
    {'id': 'A-2', 'status': 'BOOKED'},
    {'id': 'A-3', 'status': 'DRAWN'},
    {'id': 'A-4', 'status': 'READY'},
    {'id': 'A-5', 'status': 'BOOKED'},
    {'id': 'A-6', 'status': 'READY'},
    {'id': 'A-7', 'status': 'READY'},
    {'id': 'A-8', 'status': 'BOOKED'},
    {'id': 'A-9', 'status': 'READY'},
    {'id': 'A-10', 'status': 'READY'},
    {'id': 'A-11', 'status': 'BOOKED'},
    {'id': 'A-12', 'status': 'READY'},
    {'id': 'A-13', 'status': 'DRAWN'},
    {'id': 'A-14', 'status': 'BOOKED'},
    {'id': 'A-15', 'status': 'READY'},
    {'id': 'A-16', 'status': 'READY'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('PLOT VISUALIZATION'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Color Legends Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppTheme.borderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMapLegend('READY', AppTheme.success),
                  _buildMapLegend('BOOKED', AppTheme.warning),
                  _buildMapLegend('DRAWN', AppTheme.primaryPurple),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sector Space Map Matrix Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'SECTOR ALPHA SPACE MAP MATRIX',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.greyText,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Grid layout representing coordinate cells exactly like the screenshot
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: _matrixPlots.length,
                      itemBuilder: (context, index) {
                        final plotItem = _matrixPlots[index];
                        return _buildCoordinateCell(plotItem);
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.tune, color: AppTheme.greyText, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Click coordinate map indexes to inspect registry value details.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: AppTheme.greyText, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.greyText),
        ),
      ],
    );
  }

  Widget _buildCoordinateCell(Map<String, dynamic> item) {
    final status = item['status'];
    Color bg;
    Color fg;

    if (status == 'READY') {
      bg = AppTheme.success.withOpacity(0.06);
      fg = AppTheme.success;
    } else if (status == 'BOOKED') {
      bg = AppTheme.warning.withOpacity(0.06);
      fg = AppTheme.warning;
    } else {
      bg = AppTheme.primaryPurple.withOpacity(0.06);
      fg = AppTheme.primaryPurple;
    }

    return InkWell(
      onTap: () {
        _showCellDetailsDialog(item);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fg.withOpacity(0.12), width: 1.5),
        ),
        alignment: Alignment.center,
        child: Text(
          item['id'],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: fg,
          ),
        ),
      ),
    );
  }

  void _showCellDetailsDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registry Plot Unit: ${item['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildField('Current Status', item['status']),
            _buildField('Sector/Zone', 'Sector Alpha'),
            _buildField('Calculated Dimension', '5 Marla Standard'),
            _buildField('Appraised Value', 'PKR 3,400K'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Inspecting ledger for ${item['id']}...')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryPurple),
            child: const Text('Open Registry Ledger', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.greyText, fontSize: 13, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
