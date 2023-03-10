import 'package:flutter/material.dart';

abstract class AppColors {
  static const primaryColor = Color(0xFF6750A4);
  static const onPrimaryColor = Color(0xFFFFFFFF);
  static const primaryContainerColor = Color(0xFFEADDFF);
  static const onPrimaryContainerColor = Color(0xFF21005D);

  static const secondaryColor = Color(0xFF625B71);
  static const onSecondaryColor = Color(0xFFFFFFFF);
  static const secondaryContainerColor = Color(0xFFE8DEF8);
  static const onSecondaryContainerColor = Color(0xFF1D192B);

  static const tertiaryColor = Color(0xFF7D5260);
  static const onTertiaryColor = Color(0xFFFFFFFF);
  static const tertiaryContainerColor = Color(0xFFFFD8E4);
  static const onTertiaryContainerColor = Color(0xFF31111D);

  static const errorColor = Color(0xFFB3261E);
  static const onErrorColor = Color(0xFFFFFFFF);
  static const errorContainerColor = Color(0xFFF9DEDC);
  static const onErrorContainerColor = Color(0xFF410E0B);

  static const backgroundColor = Color(0xFFFFFFFF);
  static const onBackgroundColor = Color(0xFF1C1B1F);

  static const surfaceColor = Color(0xFFFFFBFE);
  static const onSurfaceColor = Color(0xFF1C1B1F);

  static const surfaceVariantColor = Color(0xFFE7E0EC);
  static const onSurfaceVariantColor = Color(0xFF49454F);

  static const outlineColor = Color(0xFF79747E);
  static const outlineVariantColor = Color(0xFFCAC4D0);
}

const lightColorSchema = ColorScheme.light(
  primary: AppColors.primaryColor,
  onPrimary: AppColors.onPrimaryColor,
  primaryContainer: AppColors.primaryContainerColor,
  onPrimaryContainer: AppColors.onPrimaryContainerColor,
  secondary: AppColors.secondaryColor,
  onSecondary: AppColors.onSecondaryColor,
  secondaryContainer: AppColors.secondaryContainerColor,
  onSecondaryContainer: AppColors.onSecondaryContainerColor,
  tertiary: AppColors.tertiaryColor,
  onTertiary: AppColors.onTertiaryColor,
  tertiaryContainer: AppColors.tertiaryContainerColor,
  onTertiaryContainer: AppColors.onTertiaryContainerColor,
  error: AppColors.errorColor,
  onError: AppColors.onErrorColor,
  errorContainer: AppColors.errorContainerColor,
  onErrorContainer: AppColors.onErrorContainerColor,
  background: AppColors.backgroundColor,
  onBackground: AppColors.onBackgroundColor,
  surface: AppColors.surfaceColor,
  onSurface: AppColors.onSurfaceColor,
  surfaceVariant: AppColors.surfaceVariantColor,
  onSurfaceVariant: AppColors.onSurfaceVariantColor,
  outline: AppColors.outlineColor,
  outlineVariant: AppColors.outlineVariantColor,
);
