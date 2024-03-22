import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFF086494),
        content: Text(message),
      ),
    );
  }
}
