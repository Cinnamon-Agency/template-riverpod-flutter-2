import 'package:cinnamon_riverpod_2/features/shared/buttons/text_icon_button.dart';
import 'package:cinnamon_riverpod_2/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/enums.dart';
import '../../../theme/icons/app_icons.dart';
import '../../shared/buttons/secondary_button.dart';
import '../controllers/onboarding_controller.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Hero(
                          tag: HeroAnimationTags.splashLogo,
                          child: AppIcons.icon(
                            Assets.icons.earthPlane,
                            size: 100,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 72),
                        Text(
                          'Start your\nTripFinder journey!',
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        const Text('Create an account to start planning your trips.'),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildSignInButton(TextIconButton.emailSignIn(
                    onPressed: () => controller.onPressSignUp(context),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Or',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  _buildSignInButton(SecondaryButton(
                    text: 'Log in',
                    onPressed: () => controller.onPressLogin(context),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(Widget button) {
    return Container(
      height: 48,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: button,
    );
  }
}
