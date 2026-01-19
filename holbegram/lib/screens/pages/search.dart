import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Search page showing uploaded images in a staggered grid.
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    // Skip Firestore streams when Firebase isn't configured (e.g. web preview).
    if (Firebase.apps.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: const InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
          ),
        ),
        body: const SizedBox.shrink(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<QueryDocumentSnapshot> data = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.count(
              crossAxisCount: 3,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> postData =
                    data[index].data() as Map<String, dynamic>;
                return Image.network(
                  postData['postUrl'] as String,
                  fit: BoxFit.cover,
                );
              },
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
          );
        },
      ),
    );
  }
}
