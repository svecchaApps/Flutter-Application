import 'package:flutter/material.dart';

class CustomSnackbar {
  final String message;

  CustomSnackbar({
    required this.message,
  });

  // Build method that returns a SnackBar
  SnackBar build() {
    return SnackBar(
      content: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style:
                  const TextStyle(color: Colors.black), // Standard text color
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Static method to show the Snackbar
  static void show(BuildContext context, String message) {
    final snackbar = CustomSnackbar(message: message);
    ScaffoldMessenger.of(context).showSnackBar(snackbar.build());
  }
}
