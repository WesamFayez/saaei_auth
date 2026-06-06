import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_loading_indicator.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset('assets/authBG.png', fit: BoxFit.cover),
    );
  }
}

class AuthLoadingOverlay extends StatelessWidget {
  const AuthLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLoadingOverlay();
  }
}

class AuthAppLogo extends StatelessWidget {
  const AuthAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/logo.png',
        width: 190.w,
        height: 70.h,
        fit: BoxFit.contain,
      ),
    );
  }
}

class AuthLabel extends StatelessWidget {
  final String text;
  const AuthLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.cairoMedium.copyWith(
        color: AppColors.white,
        fontSize: 16.sp,
      ),
    );
  }
}

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        child: Image.asset(
          'assets/back-icon-white.png',
          width: 18.w,
          height: 18.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class AuthBrokerBadge extends StatelessWidget {
  final String text;
  const AuthBrokerBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.login_outlined, color: AppColors.white, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: AppTextStyles.cairoBold.copyWith(
              color: AppColors.white,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _item(Icons.headset_mic_outlined, AppStrings.contactUs),
        SizedBox(width: 20.w),
        Container(height: 30.h, width: 1.w, color: AppColors.white.withOpacity(0.24)),
        SizedBox(width: 20.w),
        _item(Icons.info_outline, AppStrings.aboutSaaei),
      ],
    );
  }

  Widget _item(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: AppColors.white, size: 22.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.cairoRegular.copyWith(
              color: AppColors.white,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
