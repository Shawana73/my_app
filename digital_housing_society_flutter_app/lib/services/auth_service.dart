import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;
  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  static Future<void> registerApplicant({
    required String fullName,
    required String email,
    required String phone,
    required String cnic,
    required String password,
  }) async {
    final existing = await _db.collection('applicants').where('cnic', isEqualTo: cnic).limit(1).get();
    if (existing.docs.isNotEmpty) {
      throw Exception('This CNIC is already registered.');
    }

    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final uid = credential.user!.uid;
    await credential.user!.updateDisplayName(fullName);

    await _db.collection('applicants').doc(uid).set({
      'userId': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'role': 'applicant',
      'applicationStatus': 'Not Submitted',
      'paymentStatus': 'Unpaid',
      'ballotingStatus': 'Not Participated',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logout() => _auth.signOut();

  static Future<DocumentSnapshot<Map<String, dynamic>>> profile() async {
    final uid = currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    return _db.collection('applicants').doc(uid).get();
  }
}
