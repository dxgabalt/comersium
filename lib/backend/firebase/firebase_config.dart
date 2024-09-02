import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBMZaNzJvMg5WBUTywKAyUVW6pgaF9YAyY",
            authDomain: "comersium-cda28.firebaseapp.com",
            projectId: "comersium-cda28",
            storageBucket: "comersium-cda28.appspot.com",
            messagingSenderId: "959499290794",
            appId: "1:959499290794:web:7a1a4bf4b4fe607c38e8d3",
            measurementId: "G-2RE2XNE025"));
  } else {
    await Firebase.initializeApp();
  }
}
