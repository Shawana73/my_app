import 'package:flutter/material.dart';
import '../models/society_models.dart';

class DealerVerificationScreen extends StatefulWidget {
  const DealerVerificationScreen({Key? key}) : super(key: key);

  @override
  State<DealerVerificationScreen> createState() => _DealerVerificationScreenState();
}

class _DealerVerificationScreenState extends State<DealerVerificationScreen> {
  String _term = "";

  final List<Dealer> _dealers = [
    Dealer(id: "D-902", name: "Sikander Gohar Estates", agencyName: "Gohar Corporate Partners", phone: "+92 321 029102", email: "s@gohar.com", cnic: "35102-1290321-1", regNo: "REG-SHS-991", isVerified: false),
    Dealer(id: "D-903", name: "DHA Platinum Builders", agencyName: "Platinum Housing Solutions", phone: "+92 331 445511", email: "info@plat.com", cnic: "35102-0091029-4", regNo: "REG-SHS-452", isVerified: true),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _dealers.where((d) => d.name.toLowerCase().contains(_term.toLowerCase()) || d.agencyName.toLowerCase().contains(_term.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Verify Agency Dealers', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
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
                    _term = val;
                  });
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.handshake_outlined, color: Color(0xFF8E8EA9)),
                  hintText: "Search dealer name or agency registration...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No dealers in registration queue.'))
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final d = filtered[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d.regNo, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF), fontSize: 11)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: d.isVerified ? const Color(0xFF22C55E).withOpacity(0.08) : const Color(0xFFF59E0B).withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                            child: Text(d.isVerified ? 'VERIFIED' : 'AWAITING APPROVAL', style: TextStyle(color: d.isVerified ? const Color(0xFF22C55E) : const Color(0xFFF59E0B), fontSize: 8, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(d.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F1F39))),
                      Text(d.agencyName, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 12)),
                      const Divider(height: 24, color: Color(0xFFF5F3FF)),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 14, color: Color(0xFF8E8EA9)),
                          const SizedBox(width: 6),
                          Text(d.phone, style: const TextStyle(color: Color(0xFF1F1F39), fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (!d.isVerified)
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    final idx = _dealers.indexWhere((it) => it.id == d.id);
                                    if (idx != -1) {
                                      _dealers[idx] = Dealer(id: d.id, name: d.name, agencyName: d.agencyName, phone: d.phone, email: d.email, cnic: d.cnic, regNo: d.regNo, isVerified: true);
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dealer agency approved.'), backgroundColor: Color(0xFF22C55E)));
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                child: const Text('Approve Agency', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.cancel_outlined, color: Color(0xFFEF4444)),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Verification registry deleted.')));
                              },
                            )
                          ],
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
