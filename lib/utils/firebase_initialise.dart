import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mausam/screens/home_screen.dart';

class FirebaseInitialise {
  // Initializing Firebase
  static Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    // automatically sign in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
    return firebaseApp;
  }
}
