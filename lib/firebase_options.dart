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
    apiKey: 'AIzaSyB2Xhl-O6cqgf8RmcM239BibscTIcl2ToI',
    appId: '1:594811965904:web:e2091da61d356ed744a9d5',
    messagingSenderId: '594811965904',
    projectId: 'vougames-bc96d',
    authDomain: 'vougames-bc96d.firebaseapp.com',
    storageBucket: 'vougames-bc96d.firebasestorage.app',
    measurementId: 'G-SP135H7DB4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw9TRLsZAt5_MCYTgph9TWZnjIpytSFhg',
    appId: '1:594811965904:android:83c0ec81db984ff644a9d5',
    messagingSenderId: '594811965904',
    projectId: 'vougames-bc96d',
    storageBucket: 'vougames-bc96d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA69GBvZ1feNgqw99r_opg0DbO8P3aMXU8',
    appId: '1:594811965904:ios:7676f9053a42e45944a9d5',
    messagingSenderId: '594811965904',
    projectId: 'vougames-bc96d',
    storageBucket: 'vougames-bc96d.firebasestorage.app',
    iosClientId: '594811965904-nrrhcc9n1re8n0vh9fhlk45ef3vjnbj4.apps.googleusercontent.com',
    iosBundleId: 'com.example.vouGames',
  );

}