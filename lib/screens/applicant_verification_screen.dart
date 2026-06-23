import 'package:flutter/material.dart';
import '../models/society_models.dart';
import 'applicant_details_screen.dart';

class ApplicantVerificationScreen extends StatefulWidget {
  const ApplicantVerificationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicantVerificationScreen> createState() => _ApplicantVerificationScreenState();
}

class _ApplicantVerificationScreenState extends State<ApplicantVerificationScreen> {
  String _searchQuery = "";
  ApplicantStatus _selectedFilter = ApplicantStatus.pending;

  final List<Applicant> _applicants = [
    Applicant(
      id: "APP-4011",
      name: "Muhammad Ali Raza",
      cnic: "35201-1902831-3",
      email: "ali.raza@gmail.com",
      phone: "+92 300 1234567",
      documentUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      sector: "Sector A - DHA",
      status: ApplicantStatus.pending,
      applicationDate: "2026-06-20",
    ),
    Applicant(
      id: "APP-4012",
      name: "Ayesha Bibi",
      cnic: "34101-7654321-2",
      email: "ayesha@gmail.com",
      phone: "+92 321 9876543",
      documentUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      sector: "Sector B - DHA",
      status: ApplicantStatus.verified,
      applicationDate: "2026-06-18",
    ),
    Applicant(
      id: "APP-4013",
      name: "Zainab Fatima",
      cnic: "42201-5291029-4",
      email: "zainab@yahoo.com",
      phone: "+92 333 4567890",
      documentUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      sector: "Sector A",
      status: ApplicantStatus.pending,
      applicationDate: "2026-06-22",
    ),
    Applicant(
      id: "APP-4014",
      name: "Haris Saleem",
      cnic: "61101-4433221-1",
      email: "haris@gmail.com",
      phone: "+92 345 1122334",
      documentUrl: "https://images.unsplash.com/photo-1554034483-04fda0d3507b",
      sector: "Sector C - Executive",
      status: ApplicantStatus.rejected,
      applicationDate: "2026-06-15",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _applicants.where((app) {
      final matchesSearch = app.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          app.cnic.contains(_searchQuery) ||
          app.id.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = app.status == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Verify Applicants', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildSearchAndChips(),
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return _buildApplicantCard(filtered[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchAndChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 12),
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
                hintText: "Search name, CNIC or applicant ID...",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFilterChip('Pending', ApplicantStatus.pending, const Color(0xFFF59E0B)),
              _buildFilterChip('Verified', ApplicantStatus.verified, const Color(0xFF22C55E)),
              _buildFilterChip('Rejected', ApplicantStatus.rejected, const Color(0xFFEF4444)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, ApplicantStatus status, Color color) {
    final isSelected = _selectedFilter == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildApplicantCard(Applicant app) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B4DFF).withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
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
                  Text(
                    app.id,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF), fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    app.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F1F39)),
                  ),
                ],
              ),
              _buildBadge(app.status),
            ],
          ),
          const SizedBox(height: 14),
          _buildInfoRow(Icons.credit_card_outlined, app.cnic),
          _buildInfoRow(Icons.phone_iphone_outlined, app.phone),
          _buildInfoRow(Icons.mail_outline, app.email),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicantDetailsScreen(applicant: app),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF7B4DFF),
                    side: const BorderSide(color: Color(0xFF7B4DFF)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('View Dossier', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              if (app.status == ApplicantStatus.pending) ...[
                const SizedBox(width: 8),
                _buildActionButton(Icons.check_circle_outline, const Color(0xFF22C55E), () {
                  _showApproveDialog(app);
                }),
                const SizedBox(width: 8),
                _buildActionButton(Icons.cancel_outlined, const Color(0xFFEF4444), () {
                  _showRejectDialog(app);
                }),
              ],
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBadge(ApplicantStatus status) {
    Color color = const Color(0xFFF59E0B);
    String label = "Pending";
    if (status == ApplicantStatus.verified) {
      color = const Color(0xFF22C55E);
      label = "Verified";
    }
    if (status == ApplicantStatus.rejected) {
      color = const Color(0xFFEF4444);
      label = "Rejected";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF8E8EA9)),
          const SizedBox(width: 8),
          Text(val, style: const TextStyle(color: Color(0xFF1F1F39), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.inbox_outlined, size: 60, color: const Color(0xFF8E8EA9).withOpacity(0.5)),
        const SizedBox(height: 12),
        const Text(
          'No applicants match criteria',
          style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 14),
        )
      ],
    );
  }

  void _showApproveDialog(Applicant app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Confirm Verification'),
        content: Text('Do you want to verify registration credentials for ${app.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF8E8EA9))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final idx = _applicants.indexWhere((item) => item.id == app.id);
                if (idx != -1) {
                  _applicants[idx] = app.copyWith(status: ApplicantStatus.verified);
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Applicant ${app.name} verified successfully.'),
                  backgroundColor: const Color(0xFF22C55E),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Verify', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(Applicant app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Reject Registration'),
        content: Text('Are you sure you want to reject the application of ${app.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back', style: TextStyle(color: Color(0xFF8E8EA9))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final idx = _applicants.indexWhere((item) => item.id == app.id);
                if (idx != -1) {
                  _applicants[idx] = app.copyWith(status: ApplicantStatus.rejected);
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Kicked application for ${app.name} from queue.'),
                  backgroundColor: const Color(0xFFEF4444),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Reject', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
