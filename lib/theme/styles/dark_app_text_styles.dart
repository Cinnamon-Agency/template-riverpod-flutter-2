import 'package:cinnamon_riverpod_2/gen/fonts.gen.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

final darkAppTextStyles = DarkAppTextStyles();

final class DarkAppTextStyles extends AppTextStyles {
  @override
  TextStyle get primaryButtonTextStyle => const TextStyle(
        fontFamily: FontFamily.manrope,
        fontWeight: FontWeight.w800,
      );

  @override
  TextStyle get titleMediumTextStyle => TextStyle(
        color: lightAppColors.backgroundColor,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get headlineLargeTextStyle => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: lightAppColors.backgroundColor,
        letterSpacing: -0.03,
      );

  @override
  TextStyle get headlineMediumTextStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: lightAppColors.backgroundColor,
      );

  @override
  TextStyle get headlineSmallTextStyle => TextStyle(
        fontSize: 18,
        color: lightAppColors.backgroundColor,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
      );

  @override
  TextStyle get bodyLargeTextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: lightAppColors.backgroundColor,
      );

  @override
  TextStyle get bodyMediumTextStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: lightAppColors.backgroundColor,
      );

  @override
  TextStyle get bodySmallTextStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: lightAppColors.backgroundColor,
      );

  @override
  TextStyle get labelMediumTextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: lightAppColors.backgroundColor,
      );

  @override
  TextStyle get labelSmallTextStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: lightAppColors.backgroundColor,
        letterSpacing: -0.02,
      );
}
