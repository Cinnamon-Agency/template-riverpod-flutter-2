import 'app_colors.dart';
import 'package:flutter/material.dart';

final darkAppColors = DarkAppColors();

class DarkAppColors extends AppColors {
  @override
  Color get primaryColor => Colors.green.shade200;

  @override
  Color get primaryColorDark => Colors.green.shade900;

  @override
  Color get secondaryColor => Colors.green.shade100;

  @override
  Color get tertiaryColor => Colors.green.shade100;

  @override
  Color get backgroundColor => const Color(0xFF111211);
}
