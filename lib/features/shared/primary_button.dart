import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 450),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(text),
      ),
    );
  }
}
