// lib/screens/applicant_verification_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';
import 'applicant_details_screen.dart';

class ApplicantVerificationScreen extends StatefulWidget {
  const ApplicantVerificationScreen({super.key});

  @override
  State<ApplicantVerificationScreen> createState() => _ApplicantVerificationScreenState();
}

class _ApplicantVerificationScreenState extends State<ApplicantVerificationScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'PENDING';

  // Local state for interactive verification demo
  final List<Applicant> _applicants = [
    Applicant(
      id: 'APP-4011',
      name: 'Muhammad Ali Raza',
      cnic: '35201-1902831-3',
      phone: '+92 300 1234567',
      email: 'ali.raza@gmail.com',
      requestedSector: 'Sector A - DHA',
      status: Status.pending,
    ),
    Applicant(
      id: 'APP-4013',
      name: 'Zainab Fatima',
      cnic: '42201-5291029-4',
      phone: '+92 333 4567890',
      email: 'zainab.f@outlook.com',
      requestedSector: 'Sector A - Premier Street',
      status: Status.pending,
    ),
    Applicant(
      id: 'APP-4022',
      name: 'Fatima Malik',
      cnic: '35202-9843210-2',
      phone: '+92 321 9876543',
      email: 'fatima.m@yahoo.com',
      requestedSector: 'Sector B - Overseas Block',
      status: Status.verified,
    ),
    Applicant(
      id: 'APP-4025',
      name: 'Usman Tariq',
      cnic: '34101-4432109-1',
      phone: '+92 301 2233445',
      email: 'usman.tariq@gov.pk',
      requestedSector: 'Sector E - Government Quota',
      status: Status.rejected,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter & Search Applicants
    final filteredApplicants = _applicants.where((applicant) {
      final matchesSearch = applicant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          applicant.cnic.contains(_searchQuery);

      bool matchesFilter = false;
      if (_selectedFilter == 'PENDING' && applicant.status == Status.pending) {
        matchesFilter = true;
      } else if (_selectedFilter == 'VERIFIED' && applicant.status == Status.verified) {
        matchesFilter = true;
      } else if (_selectedFilter == 'REJECTED' && applicant.status == Status.rejected) {
        matchesFilter = true;
      }
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('APPLICANT VERIFICATION'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter header box
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
                // Search field
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
                      hintText: 'Search applicant name, CNIC...',
                      hintStyle: TextStyle(color: AppTheme.greyText),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter chips matching screenshots exactly
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

          // Applicant Cards list
          Expanded(
            child: filteredApplicants.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.folder_open, size: 64, color: AppTheme.greyText),
                  SizedBox(height: 12),
                  Text(
                    'No Applicants Found',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                  ),
                  Text(
                    'Try changing filters or search query',
                    style: TextStyle(fontSize: 12, color: AppTheme.greyText),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredApplicants.length,
              itemBuilder: (context, index) {
                final applicant = filteredApplicants[index];
                return _buildApplicantCard(applicant);
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

  Widget _buildApplicantCard(Applicant applicant) {
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
                  applicant.id,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryPurple,
                  ),
                ),
                _buildStatusBadge(applicant.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              applicant.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('CNIC:', applicant.cnic),
            _buildDetailRow('Phone:', applicant.phone),
            _buildDetailRow('Requested:', applicant.requestedSector),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicantDetailsScreen(
                            applicant: applicant,
                            onStatusChanged: (newStatus) {
                              setState(() {
                                applicant.status = newStatus;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryPurple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'View Folder dossier',
                      style: TextStyle(color: AppTheme.primaryPurple, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (applicant.status == Status.pending) ...[
                  const SizedBox(width: 12),
                  _buildActionButton(Icons.check, AppTheme.success.withOpacity(0.1), AppTheme.success, () {
                    _showActionConfirmDialog(applicant, Status.verified);
                  }),
                  const SizedBox(width: 8),
                  _buildActionButton(Icons.close, AppTheme.rejected.withOpacity(0.1), AppTheme.rejected, () {
                    _showActionConfirmDialog(applicant, Status.rejected);
                  }),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(color: AppTheme.greyText, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(Status status) {
    Color bg;
    Color fg;
    String text;

    switch (status) {
      case Status.pending:
        bg = AppTheme.warning.withOpacity(0.1);
        fg = AppTheme.warning;
        text = 'PENDING';
        break;
      case Status.verified:
        bg = AppTheme.success.withOpacity(0.1);
        fg = AppTheme.success;
        text = 'VERIFIED';
        break;
      case Status.rejected:
        bg = AppTheme.rejected.withOpacity(0.1);
        fg = AppTheme.rejected;
        text = 'REJECTED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: fg),
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

  void _showActionConfirmDialog(Applicant applicant, Status nextStatus) {
    final title = nextStatus == Status.verified ? 'Verify Applicant' : 'Reject Applicant';
    final actionText = nextStatus == Status.verified ? 'Approve' : 'Reject';
    final col = nextStatus == Status.verified ? AppTheme.success : AppTheme.rejected;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to change status of ${applicant.name} to $actionText?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.greyText)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                applicant.status = nextStatus;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${applicant.name} is now ${nextStatus == Status.verified ? 'Verified' : 'Rejected'}'),
                  backgroundColor: col,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: col),
            child: Text(actionText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}