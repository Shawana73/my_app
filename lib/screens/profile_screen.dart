import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Admin Dashboard Settings', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildSectionLabel('PREMIUM SECURITY CONTROLS'),
            const SizedBox(height: 10),
            _buildSettingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 46,
            backgroundColor: const Color(0xFF7B4DFF).withOpacity(0.08),
            child: const Text(
              'S',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF7B4DFF)),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Shawon Gohar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F1F39))),
          const SizedBox(height: 4),
          const Text('Super Administrator - Pakistan Sector', style: TextStyle(color: Color(0xFF8E8EA9), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 4),
      child: Text(text, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
    );
  }

  Widget _buildSettingsList() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildItem(Icons.verified_user, 'Verify Admin Credentials', '2-Factor Auth is Active'),
          const Divider(height: 1, color: Color(0xFFF5F3FF)),
          _buildItem(Icons.security, 'Lock Cryptology parameters', 'Set hashing algorithms'),
          const Divider(height: 1, color: Color(0xFFF5F3FF)),
          _buildItem(Icons.cloud_sync, 'Cloud Node status', 'Primary node synchronizing'),
          const Divider(height: 1, color: Color(0xFFF5F3FF)),
          _buildItem(Icons.help_outline, 'Request Engineering Assist', 'Technical team support availability'),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String sub) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF7B4DFF)),
      title: Text(title, style: const TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold, fontSize: 13)),
      subtitle: Text(sub, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Triggered: $title')));
      },
    );
  }
}
