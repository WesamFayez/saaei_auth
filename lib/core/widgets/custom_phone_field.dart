import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';
import 'package:saaei_auth/core/utils/app_strings.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomPhoneField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        LengthLimitingTextInputFormatter(9),
      ],
      style: AppTextStyles.bodyMedium.copyWith(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: AppStrings.writePhone,
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        prefixIcon: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 12.w),
              const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
              Text(
                '+966 SA',
                style: AppTextStyles.cairoBold.copyWith(fontSize: 13.sp, color: AppColors.textPrimary),
              ),
              SizedBox(width: 8.w),
              Text('🇸🇦', style: TextStyle(fontSize: 18.sp)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                height: 20.h,
                width: 1.w,
                color: AppColors.grey.withOpacity(0.3),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey, fontSize: 13.sp),
        errorStyle: AppTextStyles.bodySmall.copyWith(fontSize: 12.sp, color: AppColors.error),
      ),
    );
  }
}
