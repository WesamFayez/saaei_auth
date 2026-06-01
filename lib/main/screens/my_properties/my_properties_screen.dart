import 'package:flutter/material.dart';
import '../../widgets/header_widget.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: HeaderWidget(title: 'عقاراتي'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  ' عقاراتي',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
