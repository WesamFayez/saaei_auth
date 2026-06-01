import 'package:flutter/material.dart';
import '../../widgets/header_widget.dart';
import '../../../extensions/navigation_extension.dart';
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
            _buildFixedHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildQuickActions(context),
                      const SizedBox(height: 30),
                      _buildMenuList(context),
                      const SizedBox(height: 40),
                      _buildSocialChannels(),
                      const SizedBox(height: 40),
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

  Widget _buildFixedHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: HeaderWidget(title: 'المزيد'),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return const Row(
      children: [
        QuickActionCard(
          title: 'طلباتي',
          icon: Icons.business_center_outlined,
        ),
        SizedBox(width: 12),
        QuickActionCard(
          title: 'المفضلة',
          icon: Icons.favorite_border,
        ),
        SizedBox(width: 12),
        QuickActionCard(
          title: 'أخبار العقار',
          icon: Icons.article_outlined,
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context) {
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
        const Center(
          child: Text(
            'قنواتنا',
            style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Cairo'),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.camera_alt_outlined),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.alternate_email),
            const SizedBox(width: 15),
            _buildSocialIcon(Icons.play_circle_outline),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.grey.shade600, size: 24),
    );
  }
}
