import 'package:flutter/material.dart';
import 'package:holbegram/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

// Favorite page showing saved posts.
class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32,
          ),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoriteProvider.savedPosts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final Map<String, dynamic> post =
                  favoriteProvider.savedPosts[index];
              return Image.network(
                post['postUrl'] as String,
                fit: BoxFit.cover,
              );
            },
          );
        },
      ),
    );
  }
}
