import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // primary
  static const Color primary = Color(0xFF38847C);
  static const Color secondary = Color(0xFF63B3AD);

  // UI
  static const Color background = Color(0xFFFFFAFA);
  static const Color authBackground = Color(0xFF38847C);
  static const Color surface = Colors.white;
  
  // Text

  static const Color primaryLight = Color(0xFFEAF2F1);
  static const Color secondaryLight = Color(0xFFF0F7F6);
  static const Color textPrimary = Color(0xFF2D4356);
  static const Color textSecondary = Color(0xFF758694);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color error = Colors.red;
}

class AppTextStyles {
  AppTextStyles._();


  static const TextStyle cairoBold = TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold);
  static const TextStyle cairoSemiBold = TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w600);
  static const TextStyle cairoMedium = TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w500);
  static const TextStyle cairoRegular = TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.normal);


  static TextStyle titleLarge = cairoSemiBold.copyWith(fontSize: 20, color: AppColors.black);
  static TextStyle bodyLarge = cairoRegular.copyWith(fontSize: 16, color: AppColors.black);
  static TextStyle bodyMedium = cairoRegular.copyWith(fontSize: 14, color: AppColors.black);
  static TextStyle labelLarge = cairoSemiBold.copyWith(fontSize: 14, color: AppColors.white);

  static TextStyle displayLarge = cairoBold.copyWith(fontSize: 32, color: AppColors.black);
  static TextStyle displayMedium = cairoBold.copyWith(fontSize: 24, color: AppColors.black);
  static TextStyle titleMedium = cairoSemiBold.copyWith(fontSize: 16, color: AppColors.black);
  static TextStyle bodySmall = cairoRegular.copyWith(fontSize: 12, color: AppColors.textSecondary);
}
