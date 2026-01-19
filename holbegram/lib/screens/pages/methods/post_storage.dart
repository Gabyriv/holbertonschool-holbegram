import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';

// Firestore helpers for creating and deleting posts.
class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload a post image and store its data in Firestore.
  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      final String postId = _firestore.collection('posts').doc().id;
      final String postUrl = await StorageMethods().uploadImageToCloudinary(
        image,
        'posts',
        isPost: true,
      );

      await _firestore.collection('posts').doc(postId).set({
        'caption': caption,
        'uid': uid,
        'username': username,
        'likes': [],
        'postId': postId,
        'datePublished': DateTime.now(),
        'postUrl': postUrl,
        'profImage': profImage,
        // Store the public id for deletes; using postId as a placeholder.
        'publicId': postId,
      });

      return 'Ok';
    } catch (error) {
      return error.toString();
    }
  }

  // Delete a post by id (publicId provided for later Cloudinary deletion).
  Future<void> deletePost(String postId, String publicId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
