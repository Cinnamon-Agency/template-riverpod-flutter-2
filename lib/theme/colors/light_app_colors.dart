import 'package:flutter/material.dart';

import 'app_colors.dart';

final lightAppColors = LightAppColors();

class LightAppColors extends AppColors {
  @override
  Color get primary100 => const Color(0xFF74b869);

  @override
  Color get primary200 => const Color(0xFF84c079);

  @override
  Color get primary300 => const Color(0xFF94c889);

  @override
  Color get primary400 => const Color(0xFFa3d09a);

  @override
  Color get primary500 => const Color(0xFFb3d8aa);

  @override
  Color get primary600 => const Color(0xFFc2e0bb);

  @override
  Color get primaryDark => Colors.green.shade900;

  @override
  Color get backgroundColor => const Color(0xFFF0F5F0);

  @override
  Color get error => const Color(0xFFa32638);
}
