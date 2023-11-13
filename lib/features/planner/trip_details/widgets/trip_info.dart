import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

/// Widget that displays basic trip info in a grid-like view.
///
/// Displays [startDate], [endDate] and description [info].
class TripInfo extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final String info;

  const TripInfo({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    context.localization.startDate.toUpperCase(),
                    style: context.theme.textTheme.labelSmall
                        ?.copyWith(color: context.theme.textTheme.labelSmall?.color?.withOpacity(0.6)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    startDate.dateString,
                    style: context.theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    context.localization.endDate.toUpperCase(),
                    style: context.theme.textTheme.labelSmall
                        ?.copyWith(color: context.theme.textTheme.labelSmall?.color?.withOpacity(0.6)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    endDate.dateString,
                    style: context.theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        Column(
          children: [
            Text(
              context.localization.description.toUpperCase(),
              style: context.theme.textTheme.labelSmall
                  ?.copyWith(color: context.theme.textTheme.labelSmall?.color?.withOpacity(0.6)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              info,
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
}
