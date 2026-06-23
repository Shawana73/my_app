import 'package:flutter/material.dart';
import '../models/society_models.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _query = "";

  final List<BallotWinner> _winners = [
    BallotWinner(
      applicant: Applicant(id: "APP-009", name: "Haroon Rashid", cnic: "35101-2910291-1", email: "h@gmail.com", phone: "+92 3", documentUrl: "", sector: "Sector A", status: ApplicantStatus.verified, applicationDate: ""),
      plot: Plot(id: "PL-B12", size: "10 Marla", location: "Sector B DHA", price: 5400, description: "", status: PlotStatus.allocated),
      ballotId: "BAL-90119",
      drawDate: "2026-06-23",
    ),
    BallotWinner(
      applicant: Applicant(id: "APP-014", name: "Zuhair Gohar", cnic: "35101-2910291-2", email: "z@gmail.com", phone: "+92 4", documentUrl: "", sector: "Sector B", status: ApplicantStatus.verified, applicationDate: ""),
      plot: Plot(id: "PL-C45", size: "5 Marla", location: "Sector C Exec", price: 3400, description: "", status: PlotStatus.allocated),
      ballotId: "BAL-90120",
      drawDate: "2026-06-23",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _winners.where((w) => w.applicant.name.toLowerCase().contains(_query.toLowerCase()) || w.plot.id.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Balloting Winners', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined, color: Color(0xFF7B4DFF)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Records exported as CSV.')));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(color: const Color(0xFFF5F3FF), borderRadius: BorderRadius.circular(16)),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    _query = val;
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Color(0xFF8E8EA9)),
                  hintText: "Search winner name or unit ID...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No results draw matches.', style: TextStyle(color: Color(0xFF8E8EA9))))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.ballotId, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF), fontSize: 11)),
                          const SizedBox(height: 2),
                          Text(item.applicant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F1F39))),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 12, color: Color(0xFF8E8EA9)),
                              const SizedBox(width: 4),
                              Text(item.plot.location, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 11)),
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFF7B4DFF).withOpacity(0.08), borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            const Text('PLOT NO', style: TextStyle(fontSize: 8, color: Color(0xFF7B4DFF), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text(item.plot.id, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF))),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
