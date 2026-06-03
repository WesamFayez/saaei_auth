import 'package:flutter/material.dart';
import 'package:saaei_auth/core/theme/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Color? color;
  const CustomLoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.secondary,
      ),
    );
  }
}

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withOpacity(0.3),
      child: const CustomLoadingIndicator(),
    );
  }
}
