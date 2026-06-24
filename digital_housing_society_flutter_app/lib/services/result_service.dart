import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultService {
  ResultService._();

  static final _db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> findResultByCnic(String cnic) async {
    final snapshot = await _db.collection('ballot_results').where('cnic', isEqualTo: cnic).limit(1).get();
    if (snapshot.docs.isEmpty) return null;
    return {'id': snapshot.docs.first.id, ...snapshot.docs.first.data()};
  }

  static Future<Map<String, dynamic>?> currentUserResult() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final profile = await _db.collection('applicants').doc(uid).get();
    final cnic = profile.data()?['cnic'];
    if (cnic == null || cnic.toString().trim().isEmpty) return null;
    return findResultByCnic(cnic.toString().trim());
  }

  static bool isSelected(Map<String, dynamic>? result) {
    final status = result?['status']?.toString().toLowerCase() ?? '';
    return status.contains('selected') && !status.contains('not');
  }
}
