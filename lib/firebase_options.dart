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
    apiKey: 'AIzaSyAccHJQcQZgyzMpb3mpQZOWFhcV8dVxsXI',
    appId: '1:485614592327:web:7f6b0709ed7f89d9c3ac62',
    messagingSenderId: '485614592327',
    projectId: 'mawhebtak-36751',
    authDomain: 'mawhebtak-36751.firebaseapp.com',
    storageBucket: 'mawhebtak-36751.firebasestorage.app',
    measurementId: 'G-F1NBRCQ81F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYfllIkUu98s-LNgbLeqSPOAxjhsj5GjQ',
    appId: '1:485614592327:android:dabba56084c1affbc3ac62',
    messagingSenderId: '485614592327',
    projectId: 'mawhebtak-36751',
    storageBucket: 'mawhebtak-36751.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2K3vXIiKpmy_XBKTQ26IHMrzMPZB2o_w',
    appId: '1:485614592327:ios:fb7be5b31cacd5dec3ac62',
    messagingSenderId: '485614592327',
    projectId: 'mawhebtak-36751',
    storageBucket: 'mawhebtak-36751.firebasestorage.app',
    iosBundleId: 'com.topbusiness.mawhebtak',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2K3vXIiKpmy_XBKTQ26IHMrzMPZB2o_w',
    appId: '1:485614592327:ios:fb7be5b31cacd5dec3ac62',
    messagingSenderId: '485614592327',
    projectId: 'mawhebtak-36751',
    storageBucket: 'mawhebtak-36751.firebasestorage.app',
    iosBundleId: 'com.topbusiness.mawhebtak',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAccHJQcQZgyzMpb3mpQZOWFhcV8dVxsXI',
    appId: '1:485614592327:web:67a2fc4bca957f9fc3ac62',
    messagingSenderId: '485614592327',
    projectId: 'mawhebtak-36751',
    authDomain: 'mawhebtak-36751.firebaseapp.com',
    storageBucket: 'mawhebtak-36751.firebasestorage.app',
    measurementId: 'G-ENZBRYGDY0',
  );
}
