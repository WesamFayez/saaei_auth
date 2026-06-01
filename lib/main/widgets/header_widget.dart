import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/logoNav.png", height: 40),
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D4356)),
        ),
        Row(
          children: [
            _buildBadgeIcon(
                Image.asset(
                  "assets/message.png",
                  width: 25,
                  height: 25,
                ),
                '4'),
            const SizedBox(width: 12),
            _buildBadgeIcon(
                Image.asset(
                  "assets/notification.png",
                  width: 32,
                  height: 32,
                ),
                '1'),
            const SizedBox(width: 12),
            Image.asset("assets/user-nav.png", width: 32, height: 32),
          ],
        ),
      ],
    );
  }

  Widget _buildBadgeIcon(Widget iconWidget, String badgeCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconWidget,
        Positioned(
          right: -4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Color(0xFFD4AF37), shape: BoxShape.circle),
            child: Text(badgeCount,
                style: const TextStyle(color: Colors.white, fontSize: 10)),
          ),
        ),
      ],
    );
  }
}
