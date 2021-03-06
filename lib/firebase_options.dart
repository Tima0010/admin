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
        return macos;
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
    apiKey: 'AIzaSyBDWkAxSQG2NJ84_l-_5hkVjKkcXGLhpaw',
    appId: '1:330603402786:web:dc0d413ab88393cf405c7b',
    messagingSenderId: '330603402786',
    projectId: 'gameroom-2ee8e',
    authDomain: 'gameroom-2ee8e.firebaseapp.com',
    storageBucket: 'gameroom-2ee8e.appspot.com',
    measurementId: 'G-VTLFDEP8H1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPX8qMzenSObjywC-k6-Edsbzc-tVP27Y',
    appId: '1:330603402786:android:2a3416cfb82116fc405c7b',
    messagingSenderId: '330603402786',
    projectId: 'gameroom-2ee8e',
    storageBucket: 'gameroom-2ee8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoVGRjnXzL8z1au5MQmZ3F8p4U0f7fDzg',
    appId: '1:330603402786:ios:4582ec536e0abd5a405c7b',
    messagingSenderId: '330603402786',
    projectId: 'gameroom-2ee8e',
    storageBucket: 'gameroom-2ee8e.appspot.com',
    androidClientId: '330603402786-c90abetf9k96uvt3vv9abdodftro151d.apps.googleusercontent.com',
    iosClientId: '330603402786-gd8b2civ6ma7knkl1kovouhg4flajjqf.apps.googleusercontent.com',
    iosBundleId: 'com.example.gameroomAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoVGRjnXzL8z1au5MQmZ3F8p4U0f7fDzg',
    appId: '1:330603402786:ios:4582ec536e0abd5a405c7b',
    messagingSenderId: '330603402786',
    projectId: 'gameroom-2ee8e',
    storageBucket: 'gameroom-2ee8e.appspot.com',
    androidClientId: '330603402786-c90abetf9k96uvt3vv9abdodftro151d.apps.googleusercontent.com',
    iosClientId: '330603402786-gd8b2civ6ma7knkl1kovouhg4flajjqf.apps.googleusercontent.com',
    iosBundleId: 'com.example.gameroomAdmin',
  );
}
