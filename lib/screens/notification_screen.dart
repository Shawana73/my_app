import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> _notifications = [
    {'title': 'Cryptographic Balloting Drawn', 'body': 'Sector C Allocation lottery completed successfully.', 'time': '10 mins ago', 'read': '0'},
    {'title': 'Payment Slip Alarm', 'body': 'Txn #PAY0918 represents unresolved bank clearance.', 'time': '1 hr ago', 'read': '0'},
    {'title': 'System Server Healthy', 'body': 'Backups registered onto secure society cloud node.', 'time': '2 days ago', 'read': '1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Color(0xFF1F1F39), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F1F39), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var element in _notifications) {
                  element['read'] = '1';
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All inbox marked read.')));
            },
            child: const Text('Mark all Read', style: TextStyle(color: Color(0xFF7B4DFF), fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final n = _notifications[index];
          final isUnread = n['read'] == '0';

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4, right: 12),
                  decoration: BoxDecoration(color: isUnread ? const Color(0xFF7B4DFF) : Colors.transparent, shape: BoxShape.circle),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(n['title']!, style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF1F1F39), fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(n['body']!, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 12)),
                      const SizedBox(height: 8),
                      Text(n['time']!, style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 16, color: Color(0xFFEF4444)),
                  onPressed: () {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
