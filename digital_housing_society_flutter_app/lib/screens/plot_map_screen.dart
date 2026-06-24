import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/luxury_card.dart';
import '../widgets/responsive_screen.dart';

class PlotMapScreen extends StatelessWidget {
  const PlotMapScreen({super.key});
  static const routeName = '/plot-map';

  @override
  Widget build(BuildContext context) {
    final plots = List.generate(30, (index) {
      final no = index + 1;
      if ([2, 7, 11, 19, 25].contains(no)) return {'no': 'A-$no', 'status': 'Booked'};
      if ([17].contains(no)) return {'no': 'A-$no', 'status': 'Selected'};
      return {'no': 'A-$no', 'status': 'Available'};
    });

    Color colorFor(String status) {
      if (status == 'Booked') return AppColors.deepPurple;
      if (status == 'Selected') return AppColors.warningOrange;
      return AppColors.successGreen;
    }

    return ResponsiveScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
          const SizedBox(height: 10),
          const Text('STATIC\nPLOT MAP', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.primaryText, height: 1.1)),
          const SizedBox(height: 8),
          const Text('Visual representation of available, booked and selected plots.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
          const SizedBox(height: 22),
          LuxuryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    _Legend(color: AppColors.successGreen, text: 'Available'),
                    SizedBox(width: 10),
                    _Legend(color: AppColors.deepPurple, text: 'Booked'),
                    SizedBox(width: 10),
                    _Legend(color: AppColors.warningOrange, text: 'Selected'),
                  ],
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/plot_map_placeholder.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('You can replace this placeholder with your own static society map image in assets/images/.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, height: 1.35)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          LuxuryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PLOT GRID PREVIEW', style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w900)),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final plot = plots[index];
                    final status = plot['status']!;
                    final color = colorFor(status);
                    return Container(
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: color, width: 1.4),
                      ),
                      child: Center(
                        child: Text(plot['no']!, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const LuxuryCard(
            child: Text('Note: This is a static map only, according to the documented project limitation. Real GIS/live map is not included.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20))),
          const SizedBox(width: 5),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText, fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }
}
