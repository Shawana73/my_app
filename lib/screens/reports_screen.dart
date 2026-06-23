import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Reports Hub', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DOWNLOADABLE OFFICIALLY SIGNED STATEMENTS', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
            const SizedBox(height: 14),
            _buildReportCard('Applicant Statistics', 'PDF Report reflecting complete residential registration queues.', Colors.orange, '9.2 MB'),
            _buildReportCard('Payment Ledger Q2', 'Excel Sheet reflecting raw financial records and cleared transactions.', Colors.green, '4.1 MB'),
            _buildReportCard('Allocated plots Registry', 'PDF Map referencing verified winners with geographical layout values.', Colors.purple, '12.8 MB'),
            const SizedBox(height: 28),
            const Text('SYSTEM REGULATORY METRICS', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            _buildGraphicMockCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String desc, Color color, String size) {
    return Builder(
      builder: (context) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.08), shape: BoxShape.circle),
              child: Icon(Icons.file_download_outlined, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading $title ($size)...')));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF7B4DFF).withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                child: Text(size, style: const TextStyle(color: Color(0xFF7B4DFF), fontWeight: FontWeight.bold, fontSize: 10)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGraphicMockCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Allocations Success Index', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
          const SizedBox(height: 4),
          const Text('Reflecting growth across the dynamic zoning sectors.', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 12)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildChartBar(30, 'Sec A'),
              _buildChartBar(80, 'Sec B'),
              _buildChartBar(45, 'Sec C'),
              _buildChartBar(95, 'Sec D'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChartBar(double height, String label) {
    return Column(
      children: [
        Container(
          width: 34,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF7B4DFF), Color(0xFF9C6BFF)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF8E8EA9))),
      ],
    );
  }
}
