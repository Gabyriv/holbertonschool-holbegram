import 'package:flutter/material.dart';

// Reusable text input widget for consistent styling across the app.
class TextFieldInput extends StatelessWidget {
  // Controller passed in by the caller for reading/writing the field value.
  final TextEditingController controller;
  // When true, hides text for password-like input.
  final bool ispassword;
  // Hint label shown when the field is empty.
  final String hintText;
  // Optional trailing icon (can be null).
  final Widget? suffixIcon;
  // Keyboard type to match the input intent (email, number, etc.).
  final TextInputType keyboardType;

  const TextFieldInput({
    super.key,
    required this.controller,
    required this.ispassword,
    required this.hintText,
    this.suffixIcon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    // Centralized border so all states use the same transparent styling.
    const OutlineInputBorder transparentBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        style: BorderStyle.none,
      ),
    );

    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: transparentBorder,
        focusedBorder: transparentBorder,
        enabledBorder: transparentBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
      ),
      textInputAction: TextInputAction.next,
      obscureText: ispassword,
    );
  }
}
