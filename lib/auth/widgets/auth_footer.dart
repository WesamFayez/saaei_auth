import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _item(Icons.headset_mic_outlined, 'اتصل بنا'),
        const SizedBox(width: 20),
        Container(height: 30, width: 1, color: Colors.white24),
        const SizedBox(width: 20),
        _item(Icons.info_outline, 'عن ساعي'),
      ],
    );
  }

  Widget _item(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
