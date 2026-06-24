import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'applicant_service.dart';
import 'notification_service.dart';

class PaymentService {
  PaymentService._();

  static final _db = FirebaseFirestore.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<String> submitPayment({
    required double amount,
    required String purpose,
    required String referenceNo,
    String method = 'Stripe Test Mode',
  }) async {
    final reference = referenceNo.trim().isEmpty ? 'STRIPE-TEST-${DateTime.now().millisecondsSinceEpoch}' : referenceNo.trim();
    final paymentNo = 'PAY-${DateTime.now().millisecondsSinceEpoch}';
    final application = await ApplicantService.latestApplication();
    final applicationId = application?['id'];
    final applicationNo = application?['applicationNo'];

    await _db.collection('payments').add({
      'userId': _uid,
      'applicationId': applicationId,
      'applicationNo': applicationNo,
      'paymentNo': paymentNo,
      'purpose': purpose,
      'amount': amount,
      'method': method,
      'referenceNo': reference,
      'status': 'Pending Verification',
      'verificationStatus': 'Pending Admin Verification',
      'isTestPayment': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    final applicantUpdates = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final appUpdates = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (purpose == 'Application Fee') {
      applicantUpdates['paymentStatus'] = 'Pending Verification';
      applicantUpdates['ballotingStatus'] = 'Not Eligible';
      appUpdates['paymentStatus'] = 'Pending Verification';
      appUpdates['ballotingStatus'] = 'Not Eligible';
    } else {
      applicantUpdates['installmentStatus'] = 'Pending Verification';
      appUpdates['installmentStatus'] = 'Pending Verification';
    }

    await _db.collection('applicants').doc(_uid).set(applicantUpdates, SetOptions(merge: true));
    if (applicationId != null) {
      await _db.collection('applications').doc(applicationId.toString()).set(appUpdates, SetOptions(merge: true));
    }

    await NotificationService.create(
      title: '$purpose Submitted',
      message: '$purpose payment has been submitted through Stripe Test Mode and is waiting for admin verification.',
      type: 'Payment',
      actionRoute: '/payment',
      extra: {'paymentNo': paymentNo, 'referenceNo': reference, 'purpose': purpose},
    );

    return reference;
  }
}
