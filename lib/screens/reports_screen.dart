// lib/screens/reports_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedSubTab = 'OVERVIEW';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('REPORTS & ANALYTICS'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Sub tabs scrolling bar matching screenshots
          Container(
            height: 60,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _buildSubTab('OVERVIEW', 'Overview', Icons.trending_up),
                const SizedBox(width: 8),
                _buildSubTab('FINANCIAL', 'Financial', Icons.attach_money),
                const SizedBox(width: 8),
                _buildSubTab('APPLICANT', 'Applicant', Icons.people_outline),
                const SizedBox(width: 8),
                _buildSubTab('PLOT', 'Plot Inventory', Icons.layers_outlined),
              ],
            ),
          ),

          // Core Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Tab specific screens
                  if (_selectedSubTab == 'OVERVIEW') _buildOverviewReport(),
                  if (_selectedSubTab == 'FINANCIAL') _buildFinancialReport(),
                  if (_selectedSubTab == 'APPLICANT') _buildApplicantReport(),
                  if (_selectedSubTab == 'PLOT') _buildPlotReport(),

                  const SizedBox(height: 24),

                  // Actions block
                  _buildActionButton('Generate PDF Report', Icons.picture_as_pdf_outlined, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Generating PDF Document...'), backgroundColor: AppTheme.primaryPurple),
                    );
                  }),
                  const SizedBox(height: 12),
                  _buildActionButton('Export to Excel', Icons.table_chart_outlined, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Exporting Excel Sheets...'), backgroundColor: AppTheme.success),
                    );
                  }),
                  const SizedBox(height: 12),
                  _buildActionButton('Schedule Auto-Report', Icons.alarm_on_outlined, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Configured Weekly System Automated Reports Email')),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTab(String code, String label, IconData icon) {
    final isSelected = _selectedSubTab == code;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSubTab = code;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryPurple : AppTheme.lightLavender,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : AppTheme.primaryPurple),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppTheme.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewReport() {
    return Column(
      children: [
        // Summary Cards Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildMetricsCard('Total Applications', '643', '12% Increase', Icons.folder),
            _buildMetricsCard('Verified Vouchers', '412', '8% Increase', Icons.check_circle_outline),
            _buildMetricsCard('Revenue Recieved', 'PKR 8.4M', '15% Growth', Icons.payments_outlined),
            _buildMetricsCard('Allotted Plots', '198', '22% Allocated', Icons.layers),
          ],
        ),
        const SizedBox(height: 20),

        // Beautiful Chart Card matching plot inventory block chart exactly
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Plot Inventory by Block',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBlockBar('Block A', 45),
                      _buildBlockBar('Block B', 60),
                      _buildBlockBar('Block C', 32),
                      _buildBlockBar('Block D', 28),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFinancialReport() {
    return Column(
      children: [
        // Mini Stats
        Row(
          children: [
            Expanded(child: _buildMetricsCard('Revenue (PKR)', 'PKR 8.4M', '15% Increase', Icons.monetization_on)),
            const SizedBox(width: 12),
            Expanded(child: _buildMetricsCard('Pending Slip Checks', 'PKR 550K', 'Awaiting Action', Icons.pending_actions)),
          ],
        ),
        const SizedBox(height: 16),

        // Recent Verified Payments matching screenshot exactly
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Verified Payments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                _buildPaymentRow('P-2024-001', 'Fatima Malik', 'PKR 250,000'),
                const Divider(height: 20, color: AppTheme.lightLavender),
                _buildPaymentRow('P-2024-002', 'Ayesha Noor', 'PKR 150,000'),
                const Divider(height: 20, color: AppTheme.lightLavender),
                _buildPaymentRow('P-2024-005', 'Sana Pervez', 'PKR 450,000'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApplicantReport() {
    return Column(
      children: [
        // Status Breakdown Card matching screens
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Status Breakdown',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatusDonutChart(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatusLegend('Verified', '63%', AppTheme.success),
                        const SizedBox(height: 8),
                        _buildStatusLegend('Pending', '25%', AppTheme.warning),
                        const SizedBox(height: 8),
                        _buildStatusLegend('Rejected', '12%', AppTheme.rejected),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Category Breakdown bar lists
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Breakdown',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                _buildBreakdownProgressBar('General', 380, 0.7),
                const SizedBox(height: 12),
                _buildBreakdownProgressBar('Overseas', 190, 0.5),
                const SizedBox(height: 12),
                _buildBreakdownProgressBar('Government', 95, 0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlotReport() {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Plot Inventory Status Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildPlotInventoryStatusRow('Available Plot Lots', '94 Lots', AppTheme.success),
                const Divider(height: 16),
                _buildPlotInventoryStatusRow('Booked Registries', '118 Lots', AppTheme.warning),
                const Divider(height: 16),
                _buildPlotInventoryStatusRow('Drawn/Allocated Residencies', '100 Lots', AppTheme.primaryPurple),
                const Divider(height: 16),
                _buildPlotInventoryStatusRow('Total Society Plots', '312 Lots', AppTheme.darkText),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsCard(String title, String value, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: AppTheme.primaryPurple),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(desc.split(' ')[0], style: const TextStyle(fontSize: 8, color: AppTheme.success, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          Text(title, style: const TextStyle(fontSize: 11, color: AppTheme.greyText, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBlockBar(String label, double val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 44,
          height: val * 1.5,
          decoration: BoxDecoration(
            color: AppTheme.primaryPurple,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.greyText, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentRow(String id, String name, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(id, style: const TextStyle(fontSize: 11, color: AppTheme.greyText, fontWeight: FontWeight.bold)),
            Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          ],
        ),
        Text(amount, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryPurple)),
      ],
    );
  }

  Widget _buildStatusDonutChart() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.primaryPurple, width: 8),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('643', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          Text('Total', style: TextStyle(fontSize: 9, color: AppTheme.greyText, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatusLegend(String label, String pct, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
        const SizedBox(width: 24),
        Text(pct, style: const TextStyle(fontSize: 12, color: AppTheme.greyText, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBreakdownProgressBar(String label, int val, double pct) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
            Text(val.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 8,
            backgroundColor: AppTheme.lightLavender,
            color: AppTheme.primaryPurple,
          ),
        ),
      ],
    );
  }

  Widget _buildPlotInventoryStatusRow(String label, String value, Color statusColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: statusColor)),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: AppTheme.primaryPurple),
        label: Text(label, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
        ),
      ),
    );
  }
}
