// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _activeTab = 'PROFILE'; // PROFILE or SETTINGS

  // System Settings state toggles
  bool _emailNotify = true;
  bool _smsAlerts = false;
  bool _twoFactor = true;
  bool _autoBackup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('ADMIN MANAGEMENT'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top Tab Switche matching screenshots exactly
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeTab = 'SETTINGS';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _activeTab == 'SETTINGS' ? AppTheme.primaryPurple : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.tune, size: 16, color: _activeTab == 'SETTINGS' ? Colors.white : AppTheme.greyText),
                            const SizedBox(width: 8),
                            Text(
                              'System Settings',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: _activeTab == 'SETTINGS' ? Colors.white : AppTheme.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeTab = 'PROFILE';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _activeTab == 'PROFILE' ? AppTheme.primaryPurple : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_outline, size: 16, color: _activeTab == 'PROFILE' ? Colors.white : AppTheme.greyText),
                            const SizedBox(width: 8),
                            Text(
                              'Admin Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: _activeTab == 'PROFILE' ? Colors.white : AppTheme.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tab contents
            if (_activeTab == 'PROFILE') _buildAdminProfileSection() else _buildSystemSettingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminProfileSection() {
    return Column(
      children: [
        // Profile Header card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.primaryPurple,
                  child: const Text(
                    'SG',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Shawon Gohar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const Text(
                  'admin@dhs.gov.pk',
                  style: TextStyle(fontSize: 13, color: AppTheme.greyText),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryPurple.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '★ Super Admin',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.primaryPurple),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload Photo modal launched')));
                  },
                  icon: const Icon(Icons.upload_outlined, size: 18),
                  label: const Text('Change Photo'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.primaryPurple),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppTheme.lightLavender),
                _buildMetadataLine(Icons.calendar_today_outlined, 'Member since Jan 2022'),
                _buildMetadataLine(Icons.trending_up, 'Last login: Today 9:15 AM'),
                _buildMetadataLine(Icons.security, '2FA Enabled'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Personal Details Form card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                _buildFormTextField('Full Name', 'Shawon Gohar'),
                const SizedBox(height: 12),
                _buildFormTextField('Employee ID', 'EMP-001'),
                const SizedBox(height: 12),
                _buildFormTextField('Department', 'Administration'),
                const SizedBox(height: 12),
                _buildFormTextField('Designation', 'Director'),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Changes saved successfully!'), backgroundColor: AppTheme.success),
                      );
                    },
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Change Password Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText),
                ),
                const SizedBox(height: 16),
                _buildFormTextField('Current Password', '********', obscure: true),
                const SizedBox(height: 12),
                _buildFormTextField('New Password', '', hint: 'New Password', obscure: true),
                const SizedBox(height: 12),
                _buildFormTextField('Confirm New Password', '', hint: 'Confirm New Password', obscure: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Admin password updated successfully!'), backgroundColor: AppTheme.rejected),
                      );
                    },
                    icon: const Icon(Icons.lock_outline, color: Colors.white),
                    label: const Text('Update Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.rejected,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSystemSettingsSection() {
    return Column(
      children: [
        // Notifications settings Group
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.notifications_active_outlined, color: AppTheme.primaryPurple, size: 20),
                    SizedBox(width: 8),
                    Text('Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                  ],
                ),
                const Divider(height: 24, color: AppTheme.lightLavender),
                _buildSettingToggle(
                  'Email Notifications',
                  'Receive updates via email',
                  _emailNotify,
                      (val) {
                    setState(() {
                      _emailNotify = val;
                    });
                  },
                ),
                _buildSettingToggle(
                  'SMS Alerts',
                  'Critical alerts via SMS',
                  _smsAlerts,
                      (val) {
                    setState(() {
                      _smsAlerts = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Security group
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.shield_outlined, color: AppTheme.primaryPurple, size: 20),
                    SizedBox(width: 8),
                    Text('Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                  ],
                ),
                const Divider(height: 24, color: AppTheme.lightLavender),
                _buildSettingToggle(
                  'Two-Factor Auth',
                  'Extra login security',
                  _twoFactor,
                      (val) {
                    setState(() {
                      _twoFactor = val;
                    });
                  },
                ),
                _buildSettingToggle(
                  'Auto Backup',
                  'Daily encrypted backups',
                  _autoBackup,
                      (val) {
                    setState(() {
                      _autoBackup = val;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // General settings Group
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.public, color: AppTheme.primaryPurple, size: 20),
                    SizedBox(width: 8),
                    Text('General', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
                  ],
                ),
                const Divider(height: 24, color: AppTheme.lightLavender),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Society Name', style: TextStyle(color: AppTheme.greyText, fontSize: 13, fontWeight: FontWeight.bold)),
                    Text('Digital Housing Society', style: TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataLine(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryPurple),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, color: AppTheme.greyText, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFormTextField(String label, String value, {bool obscure = false, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.greyText)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.lightLavender,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            initialValue: value.isNotEmpty ? value : null,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppTheme.greyText, fontSize: 13),
              border: InputBorder.none,
              isDense: true,
            ),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.darkText),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingToggle(String title, String subtitle, bool currentVal, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.darkText)),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.greyText)),
            ],
          ),
          Switch(
            value: currentVal,
            onChanged: onChanged,
            activeColor: AppTheme.primaryPurple,
          ),
        ],
      ),
    );
  }
}
