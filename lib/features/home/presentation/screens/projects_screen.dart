import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_strings.dart';
import '../widgets/header_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: const HeaderWidget(title: AppStrings.projects),
            ),
            Expanded(
              child: Center(
                child: Text(
                  AppStrings.projects,
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
