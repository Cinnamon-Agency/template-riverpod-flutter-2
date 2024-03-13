import 'package:cinnamon_riverpod_2/theme/colors/light_app_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final int totalPageNumber;

  const PageIndicator({
    super.key,
    required this.currentPageIndex,
    required this.totalPageNumber,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < totalPageNumber; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: PageIndicatorItem(isActive: currentPageIndex == i),
            ),
        ],
      );
}

class PageIndicatorItem extends StatelessWidget {
  final bool isActive;
  const PageIndicatorItem({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 8,
        width: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Theme.of(context).primaryColor : lightAppColors.primary600,
        ),
      );
}
