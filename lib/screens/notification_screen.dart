// lib/screens/notification_screen.dart

import 'package:flutter/material.dart';
import '../theme.dart';
import '../models.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<AppNotification> _notifications = [
    AppNotification(
      id: 'n1',
      title: 'New Applicant Registry',
      description: 'Muhammad Ali Raza has requested a 5 Marla plot unit in Sector A.',
      time: '10 min ago',
    ),
    AppNotification(
      id: 'n2',
      title: 'Payment Voucher Uploaded',
      description: 'Amjad Naveed submitted PKR 12,500 deposit receipt for PL-B102.',
      time: '1 hour ago',
    ),
    AppNotification(
      id: 'n3',
      title: 'Dealer Registry Pending',
      description: 'Sikander Gohar Estates submitted authorization files for verification.',
      time: '4 hours ago',
    ),
    AppNotification(
      id: 'n4',
      title: 'System Automatic Backup Success',
      description: 'Secure cloud cryptographic ledger snapshot resolved successfully.',
      time: 'Yesterday 3:00 AM',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppTheme.lightLavender,
      appBar: AppBar(
        title: const Text('NOTIFICATIONS'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                setState(() {
                  for (var n in _notifications) {
                    n.isRead = true;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notifications marked as read')),
                );
              },
              child: const Text(
                'Mark All Read',
                style: TextStyle(color: AppTheme.primaryPurple, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.notifications_off_outlined, size: 64, color: AppTheme.greyText),
            SizedBox(height: 12),
            Text('All Caught Up!', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.darkText)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _buildNotificationCard(notification);
        },
      ),
    );
  }

  Widget _buildNotificationCard(AppNotification notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: notification.isRead
                ? AppTheme.greyText.withOpacity(0.08)
                : AppTheme.primaryPurple.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.isRead ? Icons.notifications_none_outlined : Icons.notifications_active,
            color: notification.isRead ? AppTheme.greyText : AppTheme.primaryPurple,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
            ),
            Text(
              notification.time,
              style: const TextStyle(fontSize: 10, color: AppTheme.greyText),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            notification.description,
            style: const TextStyle(fontSize: 12, color: AppTheme.greyText),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 20, color: AppTheme.greyText),
          onPressed: () {
            setState(() {
              _notifications.removeWhere((n) => n.id == notification.id);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notification dismissed')),
            );
          },
        ),
      ),
    );
  }
}
