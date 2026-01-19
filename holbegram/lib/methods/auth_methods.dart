import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:holbegram/models/user.dart';

// Authentication and user persistence helpers.
class AuthMethode {
  // Firebase auth instance for sign-in and sign-up.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance for persisting user data.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // HTTP client reserved for Cloudinary requests.
  // ignore: unused_field
  final http.Client _httpClient = http.Client();

  // Login a user with email and password.
  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  // Create a new user and store the profile data.
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user!;

      final Users users = Users(
        uid: user.uid,
        email: email,
        username: username,
        bio: '',
        photoUrl: '',
        followers: const [],
        following: const [],
        posts: const [],
        saved: const [],
        searchKey: username,
      );

      await _firestore.collection('users').doc(user.uid).set(users.toJson());

      return 'success';
    } catch (error) {
      return error.toString();
    }
  }
}
