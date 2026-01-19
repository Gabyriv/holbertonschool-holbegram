import 'package:flutter/material.dart';
import 'package:holbegram/widgets/bottom_nav.dart';

// Home entry that renders the bottom navigation layout.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const BottomNav();
  }
}
