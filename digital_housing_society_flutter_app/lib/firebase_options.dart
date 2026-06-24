import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Replace this file by running: flutterfire configure
/// These placeholder values keep the project structure complete, but Firebase
/// will only work after real Firebase options are generated for your project.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBd760wp7DyaXfiyMUF_9P0V8SUFwP0bms',
    appId: '1:467512754988:web:bc3f9968ab8c4f20ace289',
    messagingSenderId: '467512754988',
    projectId: 'digital-housing-society',
    authDomain: 'digital-housing-society.firebaseapp.com',
    storageBucket: 'digital-housing-society.firebasestorage.app',
    measurementId: 'G-Z7XDZ5XYSY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFXcANSOIBgXkHSp7v6I3ZfG3J-8m38eA',
    appId: '1:467512754988:android:80d1ab6e2c046c25ace289',
    messagingSenderId: '467512754988',
    projectId: 'digital-housing-society',
    storageBucket: 'digital-housing-society.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_IOS_API_KEY',
    appId: 'REPLACE_WITH_IOS_APP_ID',
    messagingSenderId: 'REPLACE_WITH_SENDER_ID',
    projectId: 'REPLACE_WITH_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_PROJECT.appspot.com',
    iosBundleId: 'com.example.digitalHousingSociety',
  );

  static const FirebaseOptions macos = ios;
}