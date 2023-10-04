import 'package:cinnamon_riverpod_2/theme/colors/dark_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

final lightAppTextStyles = LightAppTextStyles();

class LightAppTextStyles extends AppTextStyles {
  @override
  TextStyle get primaryButtonTextStyle => TextStyle(
        color: lightAppColors.neutralsBlack,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleMediumTextStyle => TextStyle(
        color: darkAppColors.backgroundColor,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get headlineLargeTextStyle => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: darkAppColors.backgroundColor,
        letterSpacing: -0.03,
      );

  @override
  TextStyle get headlineSmallTextStyle => TextStyle(
        fontSize: 18,
        color: darkAppColors.backgroundColor,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
      );

  @override
  TextStyle get bodyLargeTextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: darkAppColors.backgroundColor,
      );

  @override
  TextStyle get bodyMediumTextStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: darkAppColors.backgroundColor,
      );

  @override
  TextStyle get bodySmallTextStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: darkAppColors.backgroundColor,
      );

  @override
  TextStyle get labelMediumTextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: darkAppColors.backgroundColor,
      );
}
