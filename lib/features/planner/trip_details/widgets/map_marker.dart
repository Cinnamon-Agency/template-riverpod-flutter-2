import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom map marker.
///
/// If [isVisited] is `false`, displays a star icon. Otherwise, displays a checkmark icon.
/// Highlights a marker that has [isSelected] set to `true`.
class MapMarker extends StatelessWidget {
  final bool isVisited;
  final bool isSelected;

  const MapMarker({
    super.key,
    this.isVisited = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isSelected ? context.theme.highlightColor : context.theme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        isVisited
            ? const Icon(
                CupertinoIcons.checkmark_alt_circle_fill,
                color: Colors.white,
              )
            : const Icon(
                CupertinoIcons.star_circle_fill,
                color: Colors.white,
              ),
      ],
    );
  }
}
