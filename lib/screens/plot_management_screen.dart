import 'package:flutter/material.dart';
import '../models/society_models.dart';
import 'add_plot_screen.dart';
import 'plot_visualization_screen.dart';

class PlotManagementScreen extends StatefulWidget {
  const PlotManagementScreen({Key? key}) : super(key: key);

  @override
  State<PlotManagementScreen> createState() => _PlotManagementScreenState();
}

class _PlotManagementScreenState extends State<PlotManagementScreen> {
  String _searchFilter = "";

  final List<Plot> _plots = [
    Plot(id: "PL-001", size: "5 Marla", location: "Sector A, DHA Phase 6", price: 3400.0, description: "Elegant roadside commercial plot with corner entry.", status: PlotStatus.available),
    Plot(id: "PL-002", size: "10 Marla", location: "Sector B, DHA Phase 6", price: 5600.0, description: "Beautiful east-facing plot near main central park.", status: PlotStatus.booked),
    Plot(id: "PL-003", size: "1 Kanal", location: "Sector E, Premier Street", price: 12000.0, description: "Luxury canal bank side facing residential block.", status: PlotStatus.allocated),
    Plot(id: "PL-004", size: "5 Simple", location: "Sector C, DHA", price: 3100.0, description: "Standard utility setup included.", status: PlotStatus.available),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _plots.where((plt) => plt.id.toLowerCase().contains(_searchFilter.toLowerCase()) || plt.location.toLowerCase().contains(_searchFilter.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Manage Plots', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Color(0xFF7B4DFF)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PlotVisualizationScreen()));
            },
          )
        ],
      ),
      body: Column(
        children: [
          _buildSearchBlock(),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.81,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return _buildPlotItem(filtered[index]);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlotScreen()),
          );
          if (result != null && result is Plot) {
            setState(() {
              _plots.add(result);
            });
          }
        },
        backgroundColor: const Color(0xFF7B4DFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBlock() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: const Color(0xFFF5F3FF), borderRadius: BorderRadius.circular(16)),
        child: TextField(
          onChanged: (val) {
            setState(() {
              _searchFilter = val;
            });
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.search, color: Color(0xFF8E8EA9)),
            hintText: "Search plots ID or locations...",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 50, color: const Color(0xFF8E8EA9).withOpacity(0.5)),
          const SizedBox(height: 12),
          const Text('No plots in catalog', style: TextStyle(color: Color(0xFF8E8EA9))),
        ],
      ),
    );
  }

  Widget _buildPlotItem(Plot p) {
    Color statColor = const Color(0xFF22C55E);
    String label = "Available";
    if (p.status == PlotStatus.booked) {
      statColor = const Color(0xFFF59E0B);
      label = "Booked";
    }
    if (p.status == PlotStatus.allocated) {
      statColor = const Color(0xFF7B4DFF);
      label = "Allocated";
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statColor.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                child: Text(label, style: TextStyle(color: statColor, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 16, color: Color(0xFF8E8EA9)),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Edit', child: Text('Modify Detail')),
                  const PopupMenuItem(value: 'Delete', child: Text('Remove Plot')),
                ],
                onSelected: (act) {
                  _onPlotOption(act, p);
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.id,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF), fontSize: 13),
              ),
              const SizedBox(height: 1),
              Text(
                p.size,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F1F39)),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Color(0xFF8E8EA9), size: 12),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      p.location,
                      style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rs. ${p.price.toStringAsFixed(0)} /m', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
              GestureDetector(
                onTap: () {
                  _showPlotBottomSheet(p);
                },
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(color: const Color(0xFF7B4DFF).withOpacity(0.08), shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_right, color: Color(0xFF7B4DFF), size: 16),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onPlotOption(String action, Plot p) {
    if (action == 'Delete') {
      setState(() {
        _plots.removeWhere((item) => item.id == p.id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plot ${p.id} deleted from catalog.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Modify triggers coming soon.')),
      );
    }
  }

  void _showPlotBottomSheet(Plot p) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(p.id, style: const TextStyle(color: Color(0xFF7B4DFF), fontWeight: FontWeight.bold)),
                  Text('Rs. ${p.price.toStringAsFixed(2)} /m', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Text(p.size, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(p.location, style: const TextStyle(color: Color(0xFF8E8EA9))),
              const Divider(height: 30),
              const Text('DESCRIPTION', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8E8EA9), fontSize: 10)),
              const SizedBox(height: 8),
              Text(p.description, style: const TextStyle(color: Color(0xFF1F1F39), fontSize: 13, height: 1.4)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
