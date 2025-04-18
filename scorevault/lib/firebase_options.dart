// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtpJk05yZI_A2ftnH7VBpZzlspCxillHo',
    appId: '1:721878295946:web:c5c9782383d960a14dd473',
    messagingSenderId: '721878295946',
    projectId: 'scorevault-199e9',
    authDomain: 'scorevault-199e9.firebaseapp.com',
    storageBucket: 'scorevault-199e9.firebasestorage.app',
    measurementId: 'G-EJ3PECXYRT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCpuGZqdnUSI0_x9PW8YVRJkj5P10R4K8',
    appId: '1:721878295946:android:855de1fb7960f1f54dd473',
    messagingSenderId: '721878295946',
    projectId: 'scorevault-199e9',
    storageBucket: 'scorevault-199e9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNmiPE4Y24lKa5e30od8InnZuDzEfquYE',
    appId: '1:721878295946:ios:3a02e47c95514d7f4dd473',
    messagingSenderId: '721878295946',
    projectId: 'scorevault-199e9',
    storageBucket: 'scorevault-199e9.firebasestorage.app',
    iosBundleId: 'com.app.scorevault',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNmiPE4Y24lKa5e30od8InnZuDzEfquYE',
    appId: '1:721878295946:ios:a5f657041689b66d4dd473',
    messagingSenderId: '721878295946',
    projectId: 'scorevault-199e9',
    storageBucket: 'scorevault-199e9.firebasestorage.app',
    iosBundleId: 'com.example.scorevault',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDtpJk05yZI_A2ftnH7VBpZzlspCxillHo',
    appId: '1:721878295946:web:fb7cac3ae2873fdd4dd473',
    messagingSenderId: '721878295946',
    projectId: 'scorevault-199e9',
    authDomain: 'scorevault-199e9.firebaseapp.com',
    storageBucket: 'scorevault-199e9.firebasestorage.app',
    measurementId: 'G-TFH1KTNXQK',
  );
}
