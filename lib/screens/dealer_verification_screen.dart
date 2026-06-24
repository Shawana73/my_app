// lib/screens/dealer_verification_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class DealerVerificationScreen extends StatefulWidget {
  const DealerVerificationScreen({super.key});

  @override
  State<DealerVerificationScreen> createState() => _DealerVerificationScreenState();
}

class _DealerVerificationScreenState extends State<DealerVerificationScreen> {
  String _searchQuery = '';

  final List<Dealer> _dealers = [
    Dealer(
      id: 'REG-SHS-991',
      agencyName: 'Sikander Gohar Estates',
      corporatePartner: 'Gohar Corporate Partners',
      cell: '+92 321 029102',
      cnic: '35102-1290321-1',
      status: Status.pending,
    ),
    Dealer(
      id: 'REG-SHS-452',
      agencyName: 'DHA Platinum Builders',
      corporatePartner: 'Platinum Housing Solutions',
      cell: '+92 331 445511',
      cnic: '35102-0091029-4',
      status: Status.verified,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDealers = _dealers.where((dealer) {
      return dealer.agencyName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dealer.id.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('DEALER VERIFICATION'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Container(
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
                  hintText: 'Search authorized broker agencies...',
                  hintStyle: TextStyle(color: AppTheme.greyText),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // Dealer Cards list
          Expanded(
            child: filteredDealers.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.gavel_outlined, size: 64, color: AppTheme.greyText),
                  SizedBox(height: 12),
                  Text('No Dealers Found', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredDealers.length,
              itemBuilder: (context, index) {
                final dealer = filteredDealers[index];
                return _buildDealerCard(dealer);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDealerCard(Dealer dealer) {
    final isPending = dealer.status == Status.pending;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dealer.id,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.greyText),
                ),
                _buildVerifyBadge(dealer.status),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              dealer.agencyName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.darkText),
            ),
            Text(
              dealer.corporatePartner,
              style: const TextStyle(fontSize: 13, color: AppTheme.greyText, fontWeight: FontWeight.w500),
            ),
            const Divider(height: 24, color: AppTheme.lightLavender),
            _buildDealerInfoRow('Cell:', dealer.cell),
            _buildDealerInfoRow('Ident (CNIC):', dealer.cnic),
            if (isPending) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showApproveDialog(dealer);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.success.withOpacity(0.1),
                    foregroundColor: AppTheme.success,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: const Text('Approve Broker Registration', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyBadge(Status status) {
    Color bg;
    Color fg;
    String text;

    if (status == Status.pending) {
      bg = AppTheme.warning.withOpacity(0.1);
      fg = AppTheme.warning;
      text = 'PENDING VERIFY';
    } else {
      bg = AppTheme.success.withOpacity(0.1);
      fg = AppTheme.success;
      text = 'VERIFIED';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }

  Widget _buildDealerInfoRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: AppTheme.greyText, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text(val, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _showApproveDialog(Dealer dealer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Broker Agency'),
        content: Text('Are you sure you want to verify and authorize ${dealer.agencyName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                dealer.status = Status.verified;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${dealer.agencyName} is now authorized!'),
                  backgroundColor: AppTheme.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.success),
            child: const Text('Approve', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
