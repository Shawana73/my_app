import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'notification_service.dart';

class ApplicantService {
  ApplicantService._();

  static final _db = FirebaseFirestore.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<void> submitApplication({
    required String fullName,
    required String cnic,
    required String phone,
    required String address,
    required String plotSize,
    required String plotType,
    required String preference,
  }) async {
    final applicationNo = 'APP-${DateTime.now().millisecondsSinceEpoch}';
    final data = {
      'userId': _uid,
      'applicationNo': applicationNo,
      'fullName': fullName,
      'cnic': cnic,
      'phone': phone,
      'address': address,
      'plotSize': plotSize,
      'plotType': plotType,
      'preference': preference,
      'applicationStatus': 'Submitted - Pending Verification',
      'documentsStatus': 'Not Uploaded',
      'paymentStatus': 'Unpaid',
      'ballotingStatus': 'Not Eligible',
      'adminVerificationStatus': 'Pending Review',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _db.collection('applications').add(data);
    await _db.collection('applicants').doc(_uid).set({
      'fullName': fullName,
      'phone': phone,
      'cnic': cnic,
      'applicationNo': applicationNo,
      'applicationStatus': 'Submitted - Pending Verification',
      'documentsStatus': 'Not Uploaded',
      'paymentStatus': 'Unpaid',
      'ballotingStatus': 'Not Eligible',
      'adminVerificationStatus': 'Pending Review',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await NotificationService.create(
      title: 'Application Submitted',
      message: 'Your application $applicationNo has been submitted. Upload documents and submit payment for admin verification.',
      type: 'Application',
      actionRoute: '/submit-application',
      extra: {'applicationNo': applicationNo},
    );
  }

  static Future<Map<String, dynamic>?> latestApplication() async {
    final snapshot = await _db.collection('applications').where('userId', isEqualTo: _uid).get();
    if (snapshot.docs.isEmpty) return null;
    final docs = snapshot.docs.toList();
    docs.sort((a, b) {
      final at = a.data()['createdAt'];
      final bt = b.data()['createdAt'];
      final am = at is Timestamp ? at.millisecondsSinceEpoch : 0;
      final bm = bt is Timestamp ? bt.millisecondsSinceEpoch : 0;
      return bm.compareTo(am);
    });
    return {'id': docs.first.id, ...docs.first.data()};
  }

  static Future<Map<String, dynamic>?> latestPayment({String? purpose}) async {
    Query<Map<String, dynamic>> query = _db.collection('payments').where('userId', isEqualTo: _uid);
    if (purpose != null) query = query.where('purpose', isEqualTo: purpose);
    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return null;
    final docs = snapshot.docs.toList();
    docs.sort((a, b) {
      final at = a.data()['createdAt'];
      final bt = b.data()['createdAt'];
      final am = at is Timestamp ? at.millisecondsSinceEpoch : 0;
      final bm = bt is Timestamp ? bt.millisecondsSinceEpoch : 0;
      return bm.compareTo(am);
    });
    return {'id': docs.first.id, ...docs.first.data()};
  }

  static Future<List<Map<String, dynamic>>> uploadedDocuments() async {
    final snapshot = await _db.collection('uploads').where('userId', isEqualTo: _uid).get();
    return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }
}
