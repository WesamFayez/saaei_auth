import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle: AppTextStyles.cairoRegular.copyWith(fontSize: 12.sp),
      unselectedLabelStyle: AppTextStyles.cairoRegular.copyWith(fontSize: 12.sp),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.apartment, size: 24.sp),
          label: 'المشاريع'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined, size: 24.sp),
          label: 'إسأل ساعي'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business_outlined, size: 24.sp),
          label: 'اطلب عقار'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_work_outlined, size: 24.sp),
          label: 'عقاراتي'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, size: 24.sp),
          label: 'المزيد'
        ),
      ],
    );
  }
}
