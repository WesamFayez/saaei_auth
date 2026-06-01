import 'package:flutter/material.dart';
import '../../widgets/header_widget.dart';

class AskSaaeiScreen extends StatelessWidget {
  const AskSaaeiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: HeaderWidget(title: 'إسأل ساعي'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  ' إسأل ساعي',
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
