import 'package:flutter/material.dart';

class CustomizableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingAction;
  final List<Widget> actions;
  final bool isTransparent;

  CustomizableAppBar({
    super.key,
    this.title,
    this.leadingAction,
    this.actions = const [],
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isTransparent ? Colors.transparent : null,
      shadowColor: isTransparent ? Colors.transparent : null,
      leading: Center(
        child: leadingAction,
      ),
      title: title != null ? Text(title!) : null,
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

  final _appbar = AppBar();

  double get preferredHeight => _appbar.preferredSize.height;

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
