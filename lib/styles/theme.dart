import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static const primaryFont = "Pretendard";

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    letterSpacing: -0.8,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    letterSpacing: -0.8,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle subText = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    letterSpacing: -0.8,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

    static const TextStyle body = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    letterSpacing: -0.8,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );
}