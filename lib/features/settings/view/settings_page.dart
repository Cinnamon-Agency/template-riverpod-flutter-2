import 'package:cinnamon_riverpod_2/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final SettingsController controller =
    //     ref.read(settingsControllerProvider.notifier);
    // final SettingsState state = ref.watch(settingsControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: GoRouter.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        elevation: 0.5,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SvgPicture.asset(
            Assets.images.beach,
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
