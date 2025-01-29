import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAZe8Wl9jPF-IpJQCws9d5DRFM-69ZqDgg",
            authDomain: "sveccha-11c31.firebaseapp.com",
            projectId: "sveccha-11c31",
            storageBucket: "sveccha-11c31.appspot.com",
            messagingSenderId: "904787268928",
            appId: "1:904787268928:web:a801ffdbbc6426f72456a5",
            measurementId: "G-9S553NMC5V"));
  } else {
    await Firebase.initializeApp();
  }
}
