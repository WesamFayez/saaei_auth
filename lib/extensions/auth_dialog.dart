import 'package:flutter/material.dart';

extension AuthDialogExtension on BuildContext {
  void showErrorDialog(String message) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: const Text('تنبيه', style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً', style: TextStyle(fontFamily: 'Cairo')),
          ),
        ],
      ),
    );
  }
}
