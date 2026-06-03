import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/header_widget.dart';

class AskSaaeiScreen extends StatelessWidget {
  const AskSaaeiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: const HeaderWidget(title: 'إسأل ساعي'),
            ),
            Expanded(
              child: Center(
                child: Text(
                  ' إسأل ساعي',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
