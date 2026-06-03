import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomOtpField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.w,
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 4,
          style: AppTextStyles.cairoBold.copyWith(
            fontSize: 24.sp,
            letterSpacing: 20.w,
            color: AppColors.black,
          ),
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.error,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
