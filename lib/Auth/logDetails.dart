import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginInfo extends ChangeNotifier {
  String get userName => _userName;
  String _userName = '';

  /// Whether a user has logged in.
  bool get loggedIn => _userName.isNotEmpty;

  /// Logs in a user.
  void login(String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    _userName = userName;
    notifyListeners();
  }

  /// Logs out the current user.
  void logout() {
    _userName = '';
    notifyListeners();
  }
}
