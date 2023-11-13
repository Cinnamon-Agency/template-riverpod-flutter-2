import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/rounded_icon_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A sliver app bar for a details page.
///
/// Shows an image from [imageUrl] and animates [title].
class DetailsSliverAppBar extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DetailsSliverAppBar({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      expandedHeight: 280,
      leading: Center(
        child: RoundedIconButton(
          icon: CupertinoIcons.left_chevron,
          color: Colors.white.withOpacity(0.7),
          iconColor: Colors.black,
          size: 32,
          onPressed: () => GoRouter.of(context).pop(),
          tooltipMessage: context.L.back,
        ),
      ),
      actions: [
        Center(
          child: RoundedIconButton(
            icon: CupertinoIcons.pencil,
            color: Colors.white.withOpacity(0.7),
            iconColor: Colors.black,
            size: 32,
            tooltipMessage: context.L.edit,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 16),
        title: Text(
          title.trim(),
          style: context.theme.textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  colors: [Colors.transparent, context.theme.scaffoldBackgroundColor],
                  begin: const FractionalOffset(0, 0),
                  end: const FractionalOffset(0, 1),
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
