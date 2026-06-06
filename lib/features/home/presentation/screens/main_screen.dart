import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'projects_screen.dart';
import 'ask_saaei_screen.dart';
import 'request_property_screen.dart';
import 'my_properties_screen.dart';
import 'more_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ProjectsScreen(),
    const AskSaaeiScreen(),
    const RequestPropertyScreen(),
    const MyPropertiesScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
