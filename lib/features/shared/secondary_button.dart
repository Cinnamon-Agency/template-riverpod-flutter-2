import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isDisabled ? null : onPressed,
      child: Text(text),
    );
  }
}
