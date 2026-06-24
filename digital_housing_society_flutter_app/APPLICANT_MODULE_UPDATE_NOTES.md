# Applicant Module Update Notes

These updates are for the existing configured Flutter project. Do not replace your real `lib/firebase_options.dart` file.

## Updated flow

Register/Login → Dashboard → Submit Application → Upload CNIC Front/Back + Supporting Document → Submit Stripe Test Payment → Pending Admin Verification → Admin verifies → Eligible for Balloting → Check Result → Selected applicants can view plot and submit installment payment.

## Important decisions

- Firebase Storage is not used because the project is staying on the free plan.
- File upload stores metadata only in Firestore: document type, file name, size, extension, serial number, and pending verification status.
- Payment uses only Stripe Test Mode in the applicant UI.
- Bank Challan and Easypaisa test options are removed to keep the UI aligned with the documented Stripe test-mode scope.
- Payment status stays `Pending Verification` until the admin module updates it to `Paid/Verified`.
- Balloting stays `Not Eligible` until admin verifies application, documents, and payment.

## Files changed

- lib/app.dart
- lib/screens/dashboard_screen.dart
- lib/screens/application_submission_screen.dart
- lib/screens/file_upload_screen.dart
- lib/screens/payment_screen.dart
- lib/screens/balloting_status_screen.dart
- lib/screens/notifications_screen.dart
- lib/screens/result_display_screen.dart
- lib/screens/plot_map_screen.dart
- lib/services/applicant_service.dart
- lib/services/upload_service.dart
- lib/services/payment_service.dart
- lib/services/result_service.dart
- lib/services/notification_service.dart
- firebase/firestore.rules
- pubspec.yaml
- assets/images/plot_map_placeholder.png

## After copying files

Run:

```bash
flutter clean
flutter pub get
flutter run -d chrome
```

Paste `firebase/firestore.rules` into Firebase Console → Firestore Database → Rules → Publish.
