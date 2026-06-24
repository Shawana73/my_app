# Digital Housing Society — Flutter Applicant Module

This starter project follows the supplied Digital Housing Society documentation and the purple luxury UI theme from the reference screens.

## Included applicant screens

- Splash / loading screen
- Login screen with Firebase Authentication
- Registration screen with Firebase Authentication + Firestore applicant profile
- Applicant Dashboard
- Application Submission
- File Upload with Firebase Storage + Firestore upload record
- Payment Submission / Stripe Test Mode simulation record
- Balloting Status
- Result Checking by CNIC
- Result Display
- Notifications
- Static Plot Map
- Profile / Logout

## Firebase collections used

- `applicants`
- `applications`
- `uploads`
- `payments`
- `ballot_results`
- `notifications`
- `plots`

## Setup in Android Studio

1. Create/open a Flutter project.
2. Replace/add the files from this zip into your project.
3. Run:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   Replace `lib/firebase_options.dart` with the generated file.
5. Enable **Email/Password** sign-in in Firebase Authentication.
6. Create Firestore database and Storage bucket.
7. For quick development, paste `firebase/firestore.rules` into Firestore Rules.
8. Run mobile:
   ```bash
   flutter run
   ```
   Run web:
   ```bash
   flutter run -d chrome
   ```

## Test result data

To test result checking, manually add a document in `ballot_results`:

```json
{
  "cnic": "42101-1234567-1",
  "userId": "USER_UID_OPTIONAL",
  "status": "Selected",
  "plotNo": "A-17",
  "plotSize": "5 Marla",
  "block": "Executive Block",
  "createdAt": "server timestamp"
}
```

For not selected, use `status: "Not Selected"`.

## Important note about Stripe

This starter stores a `Stripe Test Mode` payment submission record in Firestore. A real Stripe integration needs a secure backend or Firebase Cloud Function because Stripe secret keys must never be placed inside Flutter client code.
