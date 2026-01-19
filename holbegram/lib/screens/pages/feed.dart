import 'package:flutter/material.dart';
import 'package:holbegram/utils/posts.dart';

// Feed page scaffold.
class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/logo.webp',
              width: 30,
              height: 24,
            ),
          ],
        ),
        actions: const [
          Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 12),
              Icon(Icons.chat_bubble_outline),
              SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: const Posts(),
    );
  }
}
