import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final bool useOpacity;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.useOpacity = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? 
              (useOpacity ? AppColors.secondary.withOpacity(0.7) : AppColors.secondary),
          minimumSize: Size(width ?? 160.w, 42.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.white, size: 18.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(
                fontSize: 15.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
