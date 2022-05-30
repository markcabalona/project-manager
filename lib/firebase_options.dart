// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }


// 1017049445765-2qad1mk3m02bddav7sm534mel05q61v1.apps.googleusercontent.com
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALtpzju4dbRxiyjhAR4X3Sx6MGJtmn2ic',
    appId: '1:1017049445765:web:d583a243f2cbcfdd9d00ec',
    messagingSenderId: '1017049445765',
    projectId: 'todo-c7ab5',
    authDomain: 'todo-c7ab5.firebaseapp.com',
    storageBucket: 'todo-c7ab5.appspot.com',
    measurementId: 'G-8PYNK4H6EP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBInyXmy1sjSJeMddxKTPF1lgIvYQuINB8',
    appId: '1:1017049445765:android:59878164af3b02f09d00ec',
    messagingSenderId: '1017049445765',
    projectId: 'todo-c7ab5',
    storageBucket: 'todo-c7ab5.appspot.com',
  );
}
