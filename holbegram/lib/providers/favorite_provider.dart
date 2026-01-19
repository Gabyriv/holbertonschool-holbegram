import 'package:flutter/material.dart';

// Stores saved posts for the favorites page.
class FavoriteProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _savedPosts = [];

  // Expose saved posts as a read-only list.
  List<Map<String, dynamic>> get savedPosts => List.unmodifiable(_savedPosts);

  // Toggle a post in the saved list.
  void toggleSave(Map<String, dynamic> postData) {
    final String postId = postData['postId'] as String;
    final int existingIndex =
        _savedPosts.indexWhere((post) => post['postId'] == postId);

    if (existingIndex == -1) {
      _savedPosts.add(postData);
    } else {
      _savedPosts.removeAt(existingIndex);
    }

    notifyListeners();
  }
}
