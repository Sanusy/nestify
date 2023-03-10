import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const displayLarge = TextStyle(fontSize: 57);
  static const displayMedium = TextStyle(fontSize: 45);
  static const displaySmall = TextStyle(fontSize: 36);

  static const headlineLarge = TextStyle(fontSize: 32);
  static const headlineMedium = TextStyle(fontSize: 28);
  static const headlineSmall = TextStyle(fontSize: 24);

  static const titleLarge = TextStyle(fontSize: 22);
  static const titleMedium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const titleSmall =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static const labelLarge =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const labelMedium =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const labelSmall =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500);

  static const bodyLarge = TextStyle(fontSize: 16);
  static const bodyMedium = TextStyle(fontSize: 14);
  static const bodySmall = TextStyle(fontSize: 12);
}

const appTextTheme = TextTheme(
  displayLarge: AppTextStyles.displayLarge,
  displayMedium: AppTextStyles.displayLarge,
  displaySmall: AppTextStyles.displayLarge,
  headlineLarge: AppTextStyles.headlineLarge,
  headlineMedium: AppTextStyles.headlineMedium,
  headlineSmall: AppTextStyles.headlineSmall,
  titleLarge: AppTextStyles.titleLarge,
  titleMedium: AppTextStyles.titleMedium,
  titleSmall: AppTextStyles.titleSmall,
  labelLarge: AppTextStyles.labelLarge,
  labelMedium: AppTextStyles.labelMedium,
  labelSmall: AppTextStyles.labelSmall,
  bodyLarge: AppTextStyles.bodyLarge,
  bodyMedium: AppTextStyles.bodyMedium,
  bodySmall: AppTextStyles.bodySmall,
);
