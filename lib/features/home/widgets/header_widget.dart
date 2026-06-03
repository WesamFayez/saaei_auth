import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/logoNav.png", height: 40.h),
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D4356)),
        ),
        Row(
          children: [
            _buildBadgeIcon(
                Image.asset(
                  "assets/message.png",
                  width: 25.w,
                  height: 25.h,
                ),
                '4'),
            SizedBox(width: 12.w),
            _buildBadgeIcon(
                Image.asset(
                  "assets/notification.png",
                  width: 32.w,
                  height: 32.h,
                ),
                '1'),
            SizedBox(width: 12.w),
            Image.asset("assets/user-nav.png", width: 32.w, height: 32.h),
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
          left: -4.w,
          top: -4.h,
          child: Container(
            padding: EdgeInsets.all(4.r),
            decoration: const BoxDecoration(
                color: Color(0xFFD4AF37), shape: BoxShape.circle),
            child: Text(badgeCount,
                style: TextStyle(color: Colors.white, fontSize: 10.sp)),
          ),
        ),
      ],
    );
  }
}
