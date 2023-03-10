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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBzO2zzMGCLhXmrYsDjudBbKmeIbncMD1k',
    appId: '1:322883150040:web:9dced0f5dd612ee9fef7ad',
    messagingSenderId: '322883150040',
    projectId: 'comp-fe7ff',
    authDomain: 'comp-fe7ff.firebaseapp.com',
    storageBucket: 'comp-fe7ff.appspot.com',
    measurementId: 'G-RTK6YDTX4Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4DfFSdqwgbDbUMqwLTneAXa3sXav2Yjo',
    appId: '1:322883150040:android:bcb27b1c7e9b742cfef7ad',
    messagingSenderId: '322883150040',
    projectId: 'comp-fe7ff',
    storageBucket: 'comp-fe7ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC12fDi0RlMSir6gNQTBnoNJT1oFp0z2zI',
    appId: '1:322883150040:ios:066815e520b9b8e3fef7ad',
    messagingSenderId: '322883150040',
    projectId: 'comp-fe7ff',
    storageBucket: 'comp-fe7ff.appspot.com',
    iosClientId: '322883150040-fv8pilb59ume2ejc572vj2l8ck6lrfmt.apps.googleusercontent.com',
    iosBundleId: 'com.example.comp',
  );
}
