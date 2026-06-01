import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF00897B),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.apartment), label: 'المشاريع'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: 'إسأل ساعي'),
        BottomNavigationBarItem(icon: Icon(Icons.add_business_outlined), label: 'اطلب عقار'),
        BottomNavigationBarItem(icon: Icon(Icons.home_work_outlined), label: 'عقاراتي'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'المزيد'),
      ],
    );
  }
}
