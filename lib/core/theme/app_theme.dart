import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import './text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    
    scaffoldBackgroundColor: const Color(0xFFF7F6F2),
    primaryColor: AppColors.greenPrimary,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenPrimary),
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.greenPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.titleMedium.copyWith(color: Colors.white),
    ),
  );
}
