import 'package:cinnamon_riverpod_2/theme/icons/app_icons.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class TextIconButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final Color? customColor;

  const TextIconButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
    this.isDisabled = false,
    this.customColor,
  });

  factory TextIconButton.appleSignIn({VoidCallback? onPressed}) => TextIconButton(
        text: 'Continue with Apple',
        iconPath: Assets.icons.socialApple,
        onPressed: onPressed,
      );

  factory TextIconButton.googleSignIn({VoidCallback? onPressed}) => TextIconButton(
        text: 'Continue with Google',
        iconPath: Assets.icons.socialGoogle,
        onPressed: onPressed,
      );

  factory TextIconButton.emailSignIn({VoidCallback? onPressed}) => TextIconButton(
        text: 'Continue with email',
        iconPath: Assets.icons.socialEmail,
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.icon(
            iconPath,
            size: 16,
            color: Theme.of(context).textButtonTheme.style?.foregroundColor?.resolve({MaterialState.pressed}),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
