import 'package:flutter/material.dart';

class AppTextStyles {
  static const titleLarge = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const body = TextStyle(fontSize: 16, color: Colors.black87);

  static TextTheme textTheme = const TextTheme(
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    bodyMedium: body,
  );
}
