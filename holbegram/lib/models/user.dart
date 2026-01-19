import 'package:cloud_firestore/cloud_firestore.dart';

// User model for storing profile and social data.
class Users {
  // Unique user id from authentication.
  final String uid;
  // Email address for the account.
  final String email;
  // Public username displayed to others.
  final String username;
  // Short bio text for the profile.
  final String bio;
  // URL to the profile photo.
  final String photoUrl;
  // List of user ids following this user.
  final List<dynamic> followers;
  // List of user ids this user follows.
  final List<dynamic> following;
  // List of post ids created by this user.
  final List<dynamic> posts;
  // List of post ids saved by this user.
  final List<dynamic> saved;
  // Search key for quick lookups.
  final String searchKey;

  const Users({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

  // Build a Users instance from a Firestore snapshot.
  static Users fromSnap(DocumentSnapshot snap) {
    // Firestore snapshot data is stored as a map.
    final Map<String, dynamic> snapshot =
        snap.data() as Map<String, dynamic>;

    return Users(
      uid: snapshot['uid'] as String,
      email: snapshot['email'] as String,
      username: snapshot['username'] as String,
      bio: snapshot['bio'] as String,
      photoUrl: snapshot['photoUrl'] as String,
      followers: snapshot['followers'] as List<dynamic>,
      following: snapshot['following'] as List<dynamic>,
      posts: snapshot['posts'] as List<dynamic>,
      saved: snapshot['saved'] as List<dynamic>,
      searchKey: snapshot['searchKey'] as String,
    );
  }

  // Convert this user model into a JSON-friendly map.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'photoUrl': photoUrl,
      'followers': followers,
      'following': following,
      'posts': posts,
      'saved': saved,
      'searchKey': searchKey,
    };
  }
}
