import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool fullWidthSpan;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
    this.fullWidthSpan = false,
  });

  @override
  Widget build(BuildContext context) => fullWidthSpan
      ? Row(
          children: <Widget>[
            Expanded(
                child: FilledButton(
              onPressed: isDisabled ? null : onPressed,
              child: Text(text),
            ))
          ],
        )
      : FilledButton(
          onPressed: isDisabled ? null : onPressed,
          child: Text(text),
        );
}
