import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthPhoneField extends StatelessWidget {
  final TextEditingController controller;

  const AuthPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.arrow_drop_down, color: Colors.black87),
          const Text(
            '+966 SA',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(width: 8),
          const Text('🇸🇦', style: TextStyle(fontSize: 18)),
          const VerticalDivider(indent: 10, endIndent: 10, width: 25),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(9),
              ],
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'إكتب رقم الجوال',
                border: InputBorder.none,
                isDense: true,
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 13, fontFamily: 'Cairo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
