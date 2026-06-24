// lib/screens/applicant_details_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class ApplicantDetailsScreen extends StatelessWidget {
  final Applicant applicant;
  final Function(Status) onStatusChanged;

  const ApplicantDetailsScreen({
    super.key,
    required this.applicant,
    required this.onStatusChanged,
  });

  get black54 => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('DOSSIER DETAILS'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header Profile Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppTheme.primaryPurple.withOpacity(0.1),
                      child: Text(
                        applicant.name.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      applicant.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      applicant.id,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.primaryPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatusBadge(applicant.status),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Personal Information Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const Divider(height: 24, color: AppTheme.lightLavender),
                    _buildInfoRow('Full Name', applicant.name),
                    _buildInfoRow('CNIC Number', applicant.cnic),
                    _buildInfoRow('Phone Number', applicant.phone),
                    _buildInfoRow('Email Address', applicant.email),
                    _buildInfoRow('Requested Sector', applicant.requestedSector),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Uploaded Documents Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Documents Dossier',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const Divider(height: 24, color: AppTheme.lightLavender),
                    _buildDocCard(context, 'CNIC Front & Back Image', Icons.credit_card_outlined),
                    const SizedBox(height: 12),
                    _buildDocCard(context, 'DHA Registry Application Form', Icons.description_outlined),
                    const SizedBox(height: 12),
                    _buildDocCard(context, 'Domicile Certificate', Icons.verified_user_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Approve & Reject Buttons (if pending)
            if (applicant.status == Status.pending)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onStatusChanged(Status.rejected);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Applicant Rejected'),
                            backgroundColor: AppTheme.rejected,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.rejected.withOpacity(0.1),
                        foregroundColor: AppTheme.rejected,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Reject Dossier', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onStatusChanged(Status.verified);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Applicant Approved and Verified'),
                            backgroundColor: AppTheme.success,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Approve Registration', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppTheme.greyText, fontSize: 13, fontWeight: FontWeight.bold)),
          Text(val, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDocCard(BuildContext context, String name, IconData icon) {
    return InkWell(
      onTap: () {
        _showImagePreviewDialog(context, name);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.lightLavender,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.darkText),
              ),
            ),
            const Icon(Icons.remove_red_eye_outlined, color: AppTheme.greyText, size: 20),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: fg),
      ),
    );
  }

  void _showImagePreviewDialog(BuildContext context, String docName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      docName,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Simulated Document Picture with a beautiful gradient
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E9EAB), Color(0xFFEEF2F3)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),            ),
                alignment: Alignment.center,
                child:  Text(
                  'CNIC / Registry Document Scan Verified',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: [
                    Shadow(color: Colors.black.withOpacity(0.24), blurRadius: 4, offset: Offset(0, 2)),
                  ]),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading $docName...')),
                  );
                },
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text('Download Original File', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}