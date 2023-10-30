import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/icons/app_icons.dart';

class PlannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const PlannerAppBar({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            AppIcons.icon(
              Assets.icons.earthPlane,
              size: 32.0,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      actions: actions
          .map(
            (actionWidget) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: actionWidget,
            ),
          )
          .toList(),
    );
  }

  double get preferredHeight => 120;

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
