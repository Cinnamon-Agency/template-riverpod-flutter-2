import 'package:cinnamon_riverpod_2/features/splash/controller/splash_controller.dart';
import 'package:cinnamon_riverpod_2/helpers/logger.dart';
import 'package:cinnamon_riverpod_2/infra/lifecycle/lifecycle_provider.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashControllerProvider, (previous, next) {
      if (next.hasValue) {
        GoRouter.of(context).go(RoutePaths.onboarding);
      }
      if (next.hasError) {
        logger.info('Error in splash page ${next.error}');
        debugPrintStack(stackTrace: next.stackTrace!);
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(lifecycleProvider.notifier).state = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
