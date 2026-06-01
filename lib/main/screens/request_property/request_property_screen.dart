import 'package:flutter/material.dart';
import '../../widgets/header_widget.dart';

class RequestPropertyScreen extends StatelessWidget {
  const RequestPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: HeaderWidget(title: 'اطلب عقار'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  ' اطلب عقار',
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
