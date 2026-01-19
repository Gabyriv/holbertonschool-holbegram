import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

// Provides the current user to listeners.
class UserProvider with ChangeNotifier {
  // Current user model.
  late Users _user;
  // Auth helper for fetching user details.
  final AuthMethode _authMethode = AuthMethode();

  // Expose the current user.
  Users get user => _user;

  // Refresh the current user from Firestore.
  Future<void> refreshUser() async {
    final Users user = await _authMethode.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
