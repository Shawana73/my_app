// lib/screens/plot_management_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';
import 'add_plot_screen.dart';
import 'plot_visualization_screen.dart';

class PlotManagementScreen extends StatefulWidget {
  const PlotManagementScreen({super.key});

  @override
  State<PlotManagementScreen> createState() => _PlotManagementScreenState();
}

class _PlotManagementScreenState extends State<PlotManagementScreen> {
  String _searchQuery = '';

  // Local state for Plots management
  final List<Plot> _plots = [
    Plot(
      id: 'PL-001',
      size: '5 Marla',
      location: 'Sector A, DHA Phase 6',
      price: 3400.0,
      status: PlotStatus.available,
      description: 'Standard residential plot in premium block.',
    ),
    Plot(
      id: 'PL-002',
      size: '10 Marla',
      location: 'Sector B, DHA Phase 6',
      price: 5600.0,
      status: PlotStatus.booked,
      description: 'Double front corner commercial facing lot.',
    ),
    Plot(
      id: 'PL-003',
      size: '1-Kanal',
      location: 'Sector E, Premier Street',
      price: 12000.0,
      status: PlotStatus.allocated,
      description: 'Extravagant Kanal residency located on Central Boulevard.',
    ),
    Plot(
      id: 'PL-004',
      size: '5 Marla',
      location: 'Sector C, DHA Outer',
      price: 3100.0,
      status: PlotStatus.available,
      description: 'Peaceful park facing residential registry.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPlots = _plots.where((plot) {
      return plot.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plot.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          plot.size.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('PLOT MANAGEMENT'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryPurple,
        onPressed: () async {
          final newPlot = await Navigator.push<Plot>(
            context,
            MaterialPageRoute(builder: (context) => const AddPlotScreen()),
          );
          if (newPlot != null) {
            setState(() {
              _plots.add(newPlot);
            });
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Filter / Search Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                // Search Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.lightLavender,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search, color: AppTheme.greyText),
                      hintText: 'Search units, location sector...',
                      hintStyle: TextStyle(color: AppTheme.greyText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Show Interactive Map Space button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlotVisualizationScreen()),
                      );
                    },
                    icon: const Icon(Icons.map_outlined, color: AppTheme.primaryPurple),
                    label: const Text(
                      'SHOW INTERACTIVE MAP SPACE',
                      style: TextStyle(color: AppTheme.primaryPurple, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryPurple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Plots Grid
          Expanded(
            child: filteredPlots.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.map_sharp, size: 64, color: AppTheme.greyText),
                  SizedBox(height: 12),
                  Text(
                    'No Plots Found',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                  ),
                ],
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              itemCount: filteredPlots.length,
              itemBuilder: (context, index) {
                final plot = filteredPlots[index];
                return _buildPlotCard(plot);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlotCard(Plot plot) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Tag & Delete Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlotStatusBadge(plot.status),
                GestureDetector(
                  onTap: () {
                    _showDeleteConfirmDialog(plot);
                  },
                  child: const Icon(Icons.delete_outline, color: AppTheme.greyText, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              plot.id,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryPurple,
              ),
            ),
            Text(
              plot.size,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              plot.location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: AppTheme.greyText),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs. ${plot.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkText,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showPlotDetailsBottomSheet(plot);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryPurple.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, color: AppTheme.primaryPurple, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlotStatusBadge(PlotStatus status) {
    Color bg;
    Color fg;
    String text;

    switch (status) {
      case PlotStatus.available:
        bg = AppTheme.success.withOpacity(0.1);
        fg = AppTheme.success;
        text = 'AVAILABLE';
        break;
      case PlotStatus.booked:
        bg = AppTheme.warning.withOpacity(0.1);
        fg = AppTheme.warning;
        text = 'BOOKED';
        break;
      case PlotStatus.allocated:
        bg = AppTheme.primaryPurple.withOpacity(0.1);
        fg = AppTheme.primaryPurple;
        text = 'ALLOCATED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }

  void _showDeleteConfirmDialog(Plot plot) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plot Unit', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to delete ${plot.id} from inventory? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.greyText)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _plots.removeWhere((p) => p.id == plot.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${plot.id} deleted from database'),
                  backgroundColor: AppTheme.rejected,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.rejected),
            child: const Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showPlotDetailsBottomSheet(Plot plot) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plot.id, style: const TextStyle(fontSize: 14, color: AppTheme.primaryPurple, fontWeight: FontWeight.bold)),
                    Text(plot.size, style: const TextStyle(fontSize: 22, color: AppTheme.darkText, fontWeight: FontWeight.bold)),
                  ],
                ),
                _buildPlotStatusBadge(plot.status),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: AppTheme.lightLavender),
            const SizedBox(height: 12),
            _buildInfoRow('Location', plot.location),
            _buildInfoRow('Price (PKR)', 'Rs. ${plot.price.toStringAsFixed(0)}'),
            _buildInfoRow('Description', plot.description),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Editing Plot Details...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryPurple),
                    child: const Text('Edit plot unit', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppTheme.greyText, fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(val, style: const TextStyle(color: AppTheme.darkText, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}