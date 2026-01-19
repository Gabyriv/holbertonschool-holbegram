import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

// Provides the current user to listeners.
class UserProvider with ChangeNotifier {
  // Current user model (nullable until loaded).
  Users? _user;
  // Auth helper for fetching user details (lazy to avoid Firebase init errors).
  AuthMethode? _authMethode;

  // Expose the current user.
  Users? get user => _user;

  // Refresh the current user from Firestore.
  Future<void> refreshUser() async {
    // Avoid Firebase access when it isn't configured (e.g. web preview).
    if (Firebase.apps.isEmpty) {
      return;
    }
    _authMethode ??= AuthMethode();
    final Users? user = await _authMethode!.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
