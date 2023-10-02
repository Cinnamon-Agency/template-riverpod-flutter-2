import 'package:cinnamon_riverpod_2/constants/enums.dart';
import 'package:cinnamon_riverpod_2/features/onboarding/widgets/onboarding_page_view.dart';
import 'package:cinnamon_riverpod_2/features/onboarding/widgets/page_indicator.dart';
import 'package:cinnamon_riverpod_2/features/shared/primary_button.dart';
import 'package:cinnamon_riverpod_2/gen/assets.gen.dart';
import 'package:cinnamon_riverpod_2/theme/icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingControllerProvider.notifier);
    final state = ref.watch(onboardingControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: HeroAnimationTags.splashLogo,
                  child: AppIcons.icon(
                    Assets.icons.earthPlane,
                    size: 40,
                    color: Colors.green.shade200,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 400,
                        child: PageView(
                          controller: controller.pageController,
                          onPageChanged: (newPage) => controller.updateCurrentPage(newPage),

                          /// TODO: Extract this
                          children: [
                            OnboardingPageView(
                              imagePath: Assets.images.socialSharing,
                              text:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                            ),
                            OnboardingPageView(
                              imagePath: Assets.images.teamCollaboration,
                              text:
                                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                            ),
                            OnboardingPageView(
                              imagePath: Assets.images.travelling,
                              text:
                                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PageIndicator(currentPageIndex: state.currentPage, totalPageNumber: 3),
                const SizedBox(height: 16),
                Container(
                  height: 48,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: PrimaryButton(
                    /// TODO: Remove hard-coded text
                    text: 'Get Started',
                    onPressed: () => controller.onPressStart(context),
                    isDisabled: !state.onboardingFinished,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
