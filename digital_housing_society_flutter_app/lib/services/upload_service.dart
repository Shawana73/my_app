import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'applicant_service.dart';
import 'notification_service.dart';

class UploadFilePayload {
  const UploadFilePayload({
    required this.documentType,
    required this.fileName,
    required this.sizeBytes,
    required this.extension,
  });

  final String documentType;
  final String fileName;
  final int sizeBytes;
  final String extension;
}

class UploadService {
  UploadService._();

  static final _db = FirebaseFirestore.instance;
  static String get _uid => FirebaseAuth.instance.currentUser!.uid;

  static Future<List<String>> saveDocumentMetadata({
    required List<UploadFilePayload> files,
  }) async {
    if (files.isEmpty) throw Exception('Please select at least one document.');

    final application = await ApplicantService.latestApplication();
    final applicationId = application?['id'];
    final applicationNo = application?['applicationNo'] ?? 'No application number yet';

    final batch = _db.batch();
    final serials = <String>[];
    final uploadedTypes = <String>[];

    for (final file in files) {
      final serial = 'DHS-${DateTime.now().millisecondsSinceEpoch}-${serials.length + 1}';
      serials.add(serial);
      uploadedTypes.add(file.documentType);
      final ref = _db.collection('uploads').doc();
      batch.set(ref, {
        'userId': _uid,
        'applicationId': applicationId,
        'applicationNo': applicationNo,
        'documentType': file.documentType,
        'fileName': file.fileName,
        'fileSerialNumber': serial,
        'fileSizeBytes': file.sizeBytes,
        'extension': file.extension,
        'storageMode': 'Firestore Metadata Only',
        'downloadUrl': null,
        'status': 'Uploaded - Pending Verification',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }

    if (applicationId != null) {
      final appRef = _db.collection('applications').doc(applicationId.toString());
      batch.set(appRef, {
        'documentsStatus': 'Uploaded - Pending Verification',
        'uploadedDocumentTypes': FieldValue.arrayUnion(uploadedTypes),
        'adminVerificationStatus': 'Pending Review',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    final applicantRef = _db.collection('applicants').doc(_uid);
    batch.set(applicantRef, {
      'documentsStatus': 'Uploaded - Pending Verification',
      'uploadedDocumentTypes': FieldValue.arrayUnion(uploadedTypes),
      'adminVerificationStatus': 'Pending Review',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await batch.commit();

    await NotificationService.create(
      title: 'Documents Uploaded',
      message: 'Your documents have been submitted and are waiting for admin verification.',
      type: 'Upload',
      actionRoute: '/file-upload',
      extra: {'serials': serials, 'applicationNo': applicationNo},
    );

    return serials;
  }
}
