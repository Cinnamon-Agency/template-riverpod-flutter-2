import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final String? tooltipMessage;

  const RoundedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 56.0,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage ?? '',
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const CircleBorder(),
          fixedSize: Size(size, size),
        ),
        child: Icon(icon),
      ),
    );
  }
}
