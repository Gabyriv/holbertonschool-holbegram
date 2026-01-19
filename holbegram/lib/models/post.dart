import 'package:cloud_firestore/cloud_firestore.dart';

// Post model for a user upload.
class Post {
  // Caption text for the post.
  final String caption;
  // User id of the author.
  final String uid;
  // Username of the author.
  final String username;
  // List of user ids who liked the post.
  final List likes;
  // Unique id for the post.
  final String postId;
  // Publication date of the post.
  final DateTime datePublished;
  // URL to the post media.
  final String postUrl;
  // URL to the author's profile image.
  final String profImage;

  const Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  // Build a Post instance from a Firestore snapshot.
  static Post fromSnap(DocumentSnapshot snap) {
    // Firestore snapshot data is stored as a map.
    final Map<String, dynamic> snapshot =
        snap.data() as Map<String, dynamic>;

    return Post(
      caption: snapshot['caption'] as String,
      uid: snapshot['uid'] as String,
      username: snapshot['username'] as String,
      likes: snapshot['likes'] as List,
      postId: snapshot['postId'] as String,
      datePublished: (snapshot['datePublished'] as Timestamp).toDate(),
      postUrl: snapshot['postUrl'] as String,
      profImage: snapshot['profImage'] as String,
    );
  }

  // Convert this post model into a JSON-friendly map.
  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'username': username,
      'likes': likes,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}
