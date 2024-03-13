import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

class TripProgressCard extends StatelessWidget {
  final int remainingMinutes;
  final String actionButtonText;
  final VoidCallback onTapActionButton;
  final bool isActionButtonDisabled;

  const TripProgressCard({
    super.key,
    required this.remainingMinutes,
    required this.actionButtonText,
    required this.onTapActionButton,
    required this.isActionButtonDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(remainingMinutes.toString(), style: context.theme.textTheme.headlineMedium),
            const SizedBox(width: 4),
            Text(context.localization.minutesShort, style: context.theme.textTheme.bodySmall),
          ],
        ),
        PrimaryButton(
          text: actionButtonText,
          onPressed: onTapActionButton,
          isDisabled: isActionButtonDisabled,
        ),
      ],
    );
  }
}
