import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  NotificationService._();

  static final _db = FirebaseFirestore.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<void> create({
    required String title,
    required String message,
    String type = 'General',
    String? actionRoute,
    Map<String, dynamic>? extra,
  }) async {
    await _db.collection('notifications').add({
      'userId': _uid,
      'title': title,
      'message': message,
      'type': type,
      'actionRoute': actionRoute,
      'isRead': false,
      'extra': extra ?? {},
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
