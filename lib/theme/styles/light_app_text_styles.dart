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
        color: lightAppColors.neutralsBlack,
        fontWeight: FontWeight.w500,
      );

  @override
  TextStyle get headlineSmallTextStyle => TextStyle(
        color: lightAppColors.neutralsBlack,
        fontWeight: FontWeight.w700,
      );
}
