import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItemTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const MenuItemTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFF00897B), size: 24.sp),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF2D4356),
            fontFamily: 'Cairo',
          ),
        ),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      ),
    );
  }
}
