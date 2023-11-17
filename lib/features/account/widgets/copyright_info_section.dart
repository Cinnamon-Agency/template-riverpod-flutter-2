import 'package:cinnamon_riverpod_2/constants/constants.dart';
import 'package:cinnamon_riverpod_2/gen/assets.gen.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

/// Section which displays info about Cinnamon.
class CopyrightInfoSection extends StatelessWidget {
  const CopyrightInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.localization.developedBy, style: context.theme.textTheme.bodySmall),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            launchUrl(AppConstants.cinnamonUrl);
          },
          child: SvgPicture.asset(
            Assets.images.cinnamonLogo,
            width: MediaQuery.sizeOf(context).width * 0.5,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color ?? Colors.purple, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 10),
        Text(context.localization.inZagreb, style: context.theme.textTheme.bodySmall),
      ],
    );
  }
}
