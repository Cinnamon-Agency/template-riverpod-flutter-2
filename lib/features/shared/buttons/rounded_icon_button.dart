import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? iconColor;
  final double size;
  final String? tooltipMessage;

  const RoundedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.iconColor,
    this.size = 56.0,
    this.tooltipMessage,
  });

  factory RoundedIconButton.back({VoidCallback? onPressed}) => RoundedIconButton(
        icon: CupertinoIcons.left_chevron,
        color: Colors.white.withOpacity(0.8),
        iconColor: Colors.black,
        size: 32,
        onPressed: onPressed,
        tooltipMessage: 'Back',
      );

  factory RoundedIconButton.edit({VoidCallback? onPressed}) => RoundedIconButton(
        icon: CupertinoIcons.pencil,
        color: Colors.white.withOpacity(0.78),
        iconColor: Colors.black,
        size: 32,
        tooltipMessage: 'Edit',
        onPressed: onPressed,
      );

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
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}
