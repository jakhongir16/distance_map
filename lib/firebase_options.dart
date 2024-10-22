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
    apiKey: 'AIzaSyDyYRKPZQesOA-l5H7yHlF_E-sUaHRBk6Q',
    appId: '1:268306991493:web:cad3d23a68319ede275cec',
    messagingSenderId: '268306991493',
    projectId: 'map-distance-9dd9c',
    authDomain: 'map-distance-9dd9c.firebaseapp.com',
    storageBucket: 'map-distance-9dd9c.appspot.com',
    measurementId: 'G-YKVYPNC7GZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyMdrXyHlcHbRuX60ESqUhjJww7KbXwTk',
    appId: '1:268306991493:android:0f2774d81f3fccb2275cec',
    messagingSenderId: '268306991493',
    projectId: 'map-distance-9dd9c',
    storageBucket: 'map-distance-9dd9c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_9Cw2ESeQE2WcTFc2hP64DiB6aZIoi8g',
    appId: '1:268306991493:ios:5c3b5a34936d0d0d275cec',
    messagingSenderId: '268306991493',
    projectId: 'map-distance-9dd9c',
    storageBucket: 'map-distance-9dd9c.appspot.com',
    iosBundleId: 'com.example.mapDistance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_9Cw2ESeQE2WcTFc2hP64DiB6aZIoi8g',
    appId: '1:268306991493:ios:5c3b5a34936d0d0d275cec',
    messagingSenderId: '268306991493',
    projectId: 'map-distance-9dd9c',
    storageBucket: 'map-distance-9dd9c.appspot.com',
    iosBundleId: 'com.example.mapDistance',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDyYRKPZQesOA-l5H7yHlF_E-sUaHRBk6Q',
    appId: '1:268306991493:web:75ffc2de8fb8dbfb275cec',
    messagingSenderId: '268306991493',
    projectId: 'map-distance-9dd9c',
    authDomain: 'map-distance-9dd9c.firebaseapp.com',
    storageBucket: 'map-distance-9dd9c.appspot.com',
    measurementId: 'G-C4L1HGT4H5',
  );
}
