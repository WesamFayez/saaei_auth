import 'package:flutter/material.dart';

class AuthPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthPasswordField({
    super.key,
    required this.controller,
    this.hintText = 'إكتب كلمة المرور',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}
