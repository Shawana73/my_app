import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../services/result_service.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'payment_screen.dart';
import 'plot_map_screen.dart';

class ResultDisplayScreen extends StatelessWidget {
  const ResultDisplayScreen({super.key, required this.cnic, required this.result});

  final String cnic;
  final Map<String, dynamic>? result;

  @override
  Widget build(BuildContext context) {
    final status = result?['status'] ?? 'Not Found';
    final selected = ResultService.isSelected(result);

    return ResponsiveScreen(
      useGradientBackground: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
          const SizedBox(height: 40),
          LuxuryCard(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    gradient: selected ? AppColors.gradient : null,
                    color: selected ? null : AppColors.warningOrange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(selected ? Icons.emoji_events_rounded : Icons.info_rounded, color: selected ? Colors.white : AppColors.warningOrange, size: 46),
                ),
                const SizedBox(height: 18),
                Text(selected ? 'CONGRATULATIONS!' : 'RESULT STATUS', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primaryText)),
                const SizedBox(height: 8),
                Text('CNIC: $cnic', style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w800)),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(color: (selected ? AppColors.successGreen : AppColors.warningOrange).withOpacity(0.12), borderRadius: BorderRadius.circular(30)),
                  child: Text(status.toString(), style: TextStyle(color: selected ? AppColors.successGreen : AppColors.warningOrange, fontWeight: FontWeight.w900, fontSize: 15)),
                ),
                const SizedBox(height: 24),
                if (selected) ...[
                  _InfoLine(label: 'Plot No', value: result?['plotNo'] ?? 'A-17'),
                  _InfoLine(label: 'Plot Size', value: result?['plotSize'] ?? '5 Marla'),
                  _InfoLine(label: 'Block', value: result?['block'] ?? 'Executive Block'),
                  _InfoLine(label: 'Installment Plan', value: result?['installmentPlan'] ?? 'Monthly Installments'),
                  _InfoLine(label: 'First Installment', value: result?['firstInstallment'] ?? 'PKR 50,000'),
                  const SizedBox(height: 24),
                  PrimaryButton(text: 'VIEW PLOT MAP', icon: Icons.map_rounded, onPressed: () => Navigator.pushNamed(context, PlotMapScreen.routeName)),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: 'PAY FIRST INSTALLMENT',
                    icon: Icons.payments_rounded,
                    onPressed: () => Navigator.pushNamed(context, PaymentScreen.routeName, arguments: {'purpose': 'Plot Installment'}),
                  ),
                ] else
                  const Text('No selected plot record found for this CNIC. Please wait for official balloting result or contact admin.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w800))),
          Text(value.toString(), style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}
