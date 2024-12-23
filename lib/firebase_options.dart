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
    apiKey: 'AIzaSyDgzSNVILvpEzWRiSNGrPGlsXyexpWVXOo',
    appId: '1:487300826044:web:dc5c35ce3cffcaf4bce1b9',
    messagingSenderId: '487300826044',
    projectId: 'souq-algomlah-3b772',
    authDomain: 'souq-algomlah-3b772.firebaseapp.com',
    storageBucket: 'souq-algomlah-3b772.appspot.com',
    measurementId: 'G-2JYNN6WM54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASLJzUSnIe1a-nDvvG0eyoSo3xucP0RCc',
    appId: '1:487300826044:android:37e87f63a3a9b96cbce1b9',
    messagingSenderId: '487300826044',
    projectId: 'souq-algomlah-3b772',
    storageBucket: 'souq-algomlah-3b772.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqX3ecg6lDHPDUBC9g5cdC31nMUgzCt0I',
    appId: '1:487300826044:ios:619b7fbcf611d0bdbce1b9',
    messagingSenderId: '487300826044',
    projectId: 'souq-algomlah-3b772',
    storageBucket: 'souq-algomlah-3b772.appspot.com',
    iosBundleId: 'com.souqalgomlah.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqX3ecg6lDHPDUBC9g5cdC31nMUgzCt0I',
    appId: '1:487300826044:ios:ff95c020d6874c30bce1b9',
    messagingSenderId: '487300826044',
    projectId: 'souq-algomlah-3b772',
    storageBucket: 'souq-algomlah-3b772.appspot.com',
    iosBundleId: 'com.example.souqalgomlahApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDgzSNVILvpEzWRiSNGrPGlsXyexpWVXOo',
    appId: '1:487300826044:web:71ceb5a76589c6ddbce1b9',
    messagingSenderId: '487300826044',
    projectId: 'souq-algomlah-3b772',
    authDomain: 'souq-algomlah-3b772.firebaseapp.com',
    storageBucket: 'souq-algomlah-3b772.appspot.com',
    measurementId: 'G-SL9ST5Y8ET',
  );
}
