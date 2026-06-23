import 'package:flutter/material.dart';
import '../models/society_models.dart';

class PaymentVerificationScreen extends StatefulWidget {
  const PaymentVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PaymentVerificationScreen> createState() => _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends State<PaymentVerificationScreen> {
  PaymentStatus _activeStatus = PaymentStatus.pending;
  String _searchQuery = "";

  final List<Payment> _payments = [
    Payment(
      transactionId: "TXN-77291029",
      applicantName: "Amjad Naveed",
      plotId: "PL-B102",
      amount: 12500.0,
      date: "2026-06-22",
      receiptUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      status: PaymentStatus.pending,
    ),
    Payment(
      transactionId: "TXN-77291030",
      applicantName: "Hina Mansoor",
      plotId: "PL-A090",
      amount: 25000.0,
      date: "2026-06-21",
      receiptUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      status: PaymentStatus.pending,
    ),
    Payment(
      transactionId: "TXN-77291031",
      applicantName: "Kamil Shah",
      plotId: "PL-C152",
      amount: 4500.5,
      date: "2026-06-19",
      receiptUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      status: PaymentStatus.verified,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _payments.where((p) {
      final matchesSearch = p.applicantName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.transactionId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.plotId.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSearch && p.status == _activeStatus;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Verify Payments', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildFilterOptions(),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return _buildPaymentCard(filtered[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterOptions() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: Color(0xFF8E8EA9)),
                hintText: "Search name, ID, transaction...",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusButton('Pending', PaymentStatus.pending, const Color(0xFFF59E0B)),
              _buildStatusButton('Approved', PaymentStatus.verified, const Color(0xFF22C55E)),
              _buildStatusButton('Rejected', PaymentStatus.rejected, const Color(0xFFEF4444)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusButton(String txt, PaymentStatus stat, Color color) {
    final sel = _activeStatus == stat;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeStatus = stat;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: sel ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          txt,
          style: TextStyle(color: sel ? Colors.white : color, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Payment p) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.transactionId, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF), fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(p.applicantName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1F1F39))),
                ],
              ),
              Text(
                'Rs. ${p.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF22C55E)),
              )
            ],
          ),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PLOT NO', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(p.plotId, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('SUBMIT DATE', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(p.date, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showReceiptPreview(p);
                  },
                  icon: const Icon(Icons.receipt_long_outlined, size: 16),
                  label: const Text('View Slip'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7B4DFF),
                    side: const BorderSide(color: Color(0xFF7B4DFF)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              if (p.status == PaymentStatus.pending) ...[
                const SizedBox(width: 8),
                _buildActionButton(Icons.check, const Color(0xFF22C55E), () {
                  _handleApprove(p);
                }),
                const SizedBox(width: 8),
                _buildActionButton(Icons.close, const Color(0xFFEF4444), () {
                  _handleReject(p);
                }),
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.payment_outlined, size: 50, color: const Color(0xFF8E8EA9).withOpacity(0.5)),
          const SizedBox(height: 12),
          const Text('No transactions found in this state', style: TextStyle(color: Color(0xFF8E8EA9))),
        ],
      ),
    );
  }

  void _showReceiptPreview(Payment p) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF7B4DFF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Receipt Preview', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1554034483-04fda0d3507b'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Rs. ${p.amount.toStringAsFixed(2)} confirmed on slot ${p.plotId}', style: const TextStyle(fontSize: 12, color: Color(0xFF8E8EA9))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleApprove(Payment p) {
    setState(() {
      final idx = _payments.indexWhere((it) => it.transactionId == p.transactionId);
      if (idx != -1) {
        _payments[idx] = p.copyWith(status: PaymentStatus.verified);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment approved for ${p.applicantName}'), backgroundColor: const Color(0xFF22C55E)),
    );
  }

  void _handleReject(Payment p) {
    setState(() {
      final idx = _payments.indexWhere((it) => it.transactionId == p.transactionId);
      if (idx != -1) {
        _payments[idx] = p.copyWith(status: PaymentStatus.rejected);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment rejected: ${p.transactionId}'), backgroundColor: const Color(0xFFEF4444)),
    );
  }
}
