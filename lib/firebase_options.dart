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
        return ios;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALtpzju4dbRxiyjhAR4X3Sx6MGJtmn2ic',
    appId: '1:1017049445765:web:0b3b44a3a55812829d00ec',
    messagingSenderId: '1017049445765',
    projectId: 'todo-c7ab5',
    authDomain: 'todo-c7ab5.firebaseapp.com',
    storageBucket: 'todo-c7ab5.appspot.com',
    measurementId: 'G-71H6DFKPDQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBInyXmy1sjSJeMddxKTPF1lgIvYQuINB8',
    appId: '1:1017049445765:android:916e234c752774d29d00ec',
    messagingSenderId: '1017049445765',
    projectId: 'todo-c7ab5',
    storageBucket: 'todo-c7ab5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAycnJTZTC4qB8Px2Lc9RCEUhCeyjwAlZ4',
    appId: '1:1017049445765:ios:74e51c09ea21a8799d00ec',
    messagingSenderId: '1017049445765',
    projectId: 'todo-c7ab5',
    storageBucket: 'todo-c7ab5.appspot.com',
    iosClientId: '1017049445765-ceu9ju316vn3trlvq5l8jp852vrvac6e.apps.googleusercontent.com',
    iosBundleId: 'com.example.todo',
  );
}
