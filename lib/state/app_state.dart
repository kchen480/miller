import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miller/firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print('User is signed in!');
        _loggedIn = true;
      } else {
        print('User is currently signed out!');
        _loggedIn = false;
      }
      notifyListeners();
    });
  }
}
