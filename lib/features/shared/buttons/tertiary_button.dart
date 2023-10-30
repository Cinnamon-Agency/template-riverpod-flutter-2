import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const TertiaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      child: Text(text),
    );
  }
}
