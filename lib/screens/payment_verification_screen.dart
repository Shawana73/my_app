// lib/screens/payment_verification_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class PaymentVerificationScreen extends StatefulWidget {
  const PaymentVerificationScreen({super.key});

  @override
  State<PaymentVerificationScreen> createState() => _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends State<PaymentVerificationScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'PENDING';

  final List<Payment> _payments = [
    Payment(
      id: 'P-101',
      txId: 'TXN-77291029',
      applicantName: 'Amjad Naveed',
      amount: 12500.0,
      date: '2026-06-22',
      plotNo: 'PL-B102',
      receiptImage: 'slip_receipt_1.png',
      status: Status.pending,
    ),
    Payment(
      id: 'P-102',
      txId: 'TXN-77291030',
      applicantName: 'Hina Mansoor',
      amount: 25000.0,
      date: '2026-06-21',
      plotNo: 'PL-A090',
      receiptImage: 'slip_receipt_2.png',
      status: Status.pending,
    ),
    Payment(
      id: 'P-103',
      txId: 'TXN-77291040',
      applicantName: 'Fatima Malik',
      amount: 250000.0,
      date: '2026-06-18',
      plotNo: 'PL-A001',
      receiptImage: 'slip_receipt_3.png',
      status: Status.verified,
    ),
    Payment(
      id: 'P-104',
      txId: 'TXN-77291055',
      applicantName: 'Sana Pervez',
      amount: 450000.0,
      date: '2026-06-15',
      plotNo: 'PL-C004',
      receiptImage: 'slip_receipt_4.png',
      status: Status.verified,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredPayments = _payments.where((pay) {
      final matchesSearch = pay.applicantName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          pay.txId.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          pay.plotNo.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = false;
      if (_selectedFilter == 'PENDING' && pay.status == Status.pending) {
        matchesFilter = true;
      } else if (_selectedFilter == 'VERIFIED' && pay.status == Status.verified) {
        matchesFilter = true;
      } else if (_selectedFilter == 'REJECTED' && pay.status == Status.rejected) {
        matchesFilter = true;
      }
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('PAYMENT VERIFICATION'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search / Filter Header Box
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
                // Search Field
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
                      hintText: 'Search applicant bank ID, slip no...',
                      hintStyle: TextStyle(color: AppTheme.greyText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter chips
                Row(
                  children: [
                    _buildFilterChip('PENDING'),
                    const SizedBox(width: 8),
                    _buildFilterChip('VERIFIED'),
                    const SizedBox(width: 8),
                    _buildFilterChip('REJECTED'),
                  ],
                ),
              ],
            ),
          ),

          // Payment cards list
          Expanded(
            child: filteredPayments.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.payment_outlined, size: 64, color: AppTheme.greyText),
                  SizedBox(height: 12),
                  Text(
                    'No Payments Found',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) {
                final payment = filteredPayments[index];
                return _buildPaymentCard(payment);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryPurple : AppTheme.lightLavender,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppTheme.primaryPurple.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Payment payment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  payment.txId,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                Text(
                  'PKR ${payment.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              payment.applicantName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PLOT NO', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text(payment.plotNo, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('SUBMIT DATE', style: TextStyle(color: AppTheme.greyText, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text(payment.date, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showReceiptSlipDialog(payment);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryPurple.withOpacity(0.08),
                      foregroundColor: AppTheme.primaryPurple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('View Paid Slip', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                if (payment.status == Status.pending) ...[
                  const SizedBox(width: 12),
                  _buildActionButton(Icons.check, AppTheme.success.withOpacity(0.1), AppTheme.success, () {
                    _changePaymentStatus(payment, Status.verified);
                  }),
                  const SizedBox(width: 8),
                  _buildActionButton(Icons.close, AppTheme.rejected.withOpacity(0.1), AppTheme.rejected, () {
                    _changePaymentStatus(payment, Status.rejected);
                  }),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color bg, Color iconColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  void _changePaymentStatus(Payment payment, Status status) {
    setState(() {
      payment.status = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment transaction for ${payment.applicantName} marked as ${status == Status.verified ? "Verified" : "Rejected"}'),
        backgroundColor: status == Status.verified ? AppTheme.success : AppTheme.rejected,
      ),
    );
  }

  void _showReceiptSlipDialog(Payment payment) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Banner Title matching receipt dialog styling exactly
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppTheme.primaryPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Slip Receipts Preview',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Close',
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Smooth gradient card representing bank deposit slip as shown in screenshots
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE2E8F0), Color(0xFF94A3B8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.receipt_long, size: 48, color: Colors.white54),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Amount of PKR ${payment.amount.toStringAsFixed(0)} confirmed for plot units ${payment.plotNo}.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.darkText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.primaryPurple),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Dismiss', style: TextStyle(color: AppTheme.primaryPurple)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _changePaymentStatus(payment, Status.verified);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.success,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Verify Slip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}