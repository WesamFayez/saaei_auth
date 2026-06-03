import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/header_widget.dart';
import 'widgets/quick_action_card.dart';
import 'widgets/menu_item_tile.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: const HeaderWidget(title: 'المزيد'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildQuickActions(),
                      SizedBox(height: 30.h),
                      _buildMenuList(),
                      SizedBox(height: 40.h),
                      _buildSocialChannels(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        const QuickActionCard(
          title: 'طلباتي',
          icon: Icons.business_center_outlined,
        ),
        SizedBox(width: 12.w),
        const QuickActionCard(
          title: 'المفضلة',
          icon: Icons.favorite_border,
        ),
        SizedBox(width: 12.w),
        const QuickActionCard(
          title: 'أخبار العقار',
          icon: Icons.article_outlined,
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return Column(
      children: [
        MenuItemTile(
          title: 'الإعدادات',
          icon: Icons.settings_outlined,
          onTap: () {},
        ),
        MenuItemTile(
          title: 'الأسئلة الشائعة',
          icon: Icons.help_outline,
          onTap: () {},
        ),
        MenuItemTile(
          title: 'مشاركة التطبيق',
          icon: Icons.share_outlined,
          onTap: () {},
        ),
        MenuItemTile(
          title: 'حول حسابي لوسيط عقاري',
          icon: Icons.swap_horiz_outlined,
          onTap: () {},
        ),
        MenuItemTile(
          title: 'الملكية الفكرية',
          icon: Icons.copyright_outlined,
          onTap: () {},
        ),
        MenuItemTile(
          title: 'سياسة الخصوصية',
          icon: Icons.lock_outline,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSocialChannels() {
    return Column(
      children: [
        Center(
          child: Text(
            'قنواتنا',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
              fontFamily: 'Cairo'
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.facebook),
            SizedBox(width: 15.w),
            _buildSocialIcon(Icons.camera_alt_outlined),
            SizedBox(width: 15.w),
            _buildSocialIcon(Icons.alternate_email),
            SizedBox(width: 15.w),
            _buildSocialIcon(Icons.play_circle_outline),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.grey.shade600, size: 24.sp),
    );
  }
}
