import 'package:flutter/material.dart';
import '../models/society_models.dart';

class ApplicantDetailsScreen extends StatelessWidget {
  final Applicant applicant;

  const ApplicantDetailsScreen({Key? key, required this.applicant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Applicant Portfolio', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildProfileCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('PERSONAL CREDENTIALS'),
                  const SizedBox(height: 10),
                  _buildDetailsBox(),
                  const SizedBox(height: 24),
                  _buildSectionLabel('REGISTRATION ATTACHMENTS'),
                  const SizedBox(height: 10),
                  _buildDocumentViewer(context),
                  const SizedBox(height: 30),
                  _buildCommandButtons(context),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      child: Column(
        children: [
          Hero(
            tag: applicant.id,
            child: CircleAvatar(
              radius: 54,
              backgroundColor: const Color(0xFF7B4DFF).withOpacity(0.08),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFF7B4DFF).withOpacity(0.2),
                child: Text(
                  applicant.name.substring(0, 1),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            applicant.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1F1F39)),
          ),
          const SizedBox(height: 6),
          Text(
            applicant.id,
            style: const TextStyle(fontSize: 14, color: Color(0xFF7B4DFF), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color bColor = const Color(0xFFF59E0B);
    String txt = "Pending Verification";
    if (applicant.status == ApplicantStatus.verified) {
      bColor = const Color(0xFF22C55E);
      txt = "Official Resident";
    }
    if (applicant.status == ApplicantStatus.rejected) {
      bColor = const Color(0xFFEF4444);
      txt = "Application Declined";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        txt,
        style: TextStyle(color: bColor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF8E8EA9),
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildDetailsBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildFieldRow('Full Name', applicant.name),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          _buildFieldRow('CNIC Number', applicant.cnic),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          _buildFieldRow('Email', applicant.email),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          _buildFieldRow('Phone Number', applicant.phone),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          _buildFieldRow('Requested Zone', applicant.sector),
          const Divider(height: 24, color: Color(0xFFF5F3FF)),
          _buildFieldRow('Application Date', applicant.applicationDate),
        ],
      ),
    );
  }

  Widget _buildFieldRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 12)),
        Text(value, style: const TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildDocumentViewer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.description_outlined, color: Color(0xFF7B4DFF)),
                  SizedBox(width: 8),
                  Text(
                    'National_ID_Card.jpg',
                    style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.open_in_new, color: Color(0xFF7B4DFF), size: 18),
                onPressed: () {
                  _showLightBox(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _showLightBox(context),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFF5F3FF),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1554034483-04fda0d3507b'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showLightBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.maxFinite,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1554034483-04fda0d3507b'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommandButtons(BuildContext context) {
    if (applicant.status != ApplicantStatus.pending) return const SizedBox.shrink();

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Applicant approved for society quota.'), backgroundColor: Color(0xFF22C55E)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: const Text('Verify Resident', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Applicant has been declined.'), backgroundColor: Color(0xFFEF4444)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444).withOpacity(0.08),
            foregroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            elevation: 0,
          ),
          child: const Icon(Icons.cancel_outlined),
        )
      ],
    );
  }
}
