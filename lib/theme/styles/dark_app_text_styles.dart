import 'package:cinnamon_riverpod_2/theme/colors/dark_app_colors.dart';
import 'package:cinnamon_riverpod_2/theme/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

final darkAppTextStyles = DarkAppTextStyles();

final class DarkAppTextStyles extends AppTextStyles {
  @override
  TextStyle get primaryButtonTextStyle => TextStyle(
        color: darkAppColors.neutralsBlack,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get titleMediumTextStyle => TextStyle(
        color: darkAppColors.neutralsWhite,
        fontWeight: FontWeight.w500,
      );
}
