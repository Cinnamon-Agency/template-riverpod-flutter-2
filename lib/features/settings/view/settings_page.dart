import 'package:cinnamon_riverpod_2/features/shared/buttons/primary_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/language/language_provider.dart';
import 'package:cinnamon_riverpod_2/infra/language/language_service.dart';
import 'package:cinnamon_riverpod_2/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final SettingsController controller =
    //     ref.read(settingsControllerProvider.notifier);
    // final SettingsState state = ref.watch(settingsControllerProvider);
    final languageState = ref.watch(languageProvider);
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
            context.localization.settings,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
          elevation: 0.5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: Text(
                '${context.localization.changeLanguage} (${context.localization.currentLanguage} ${languageState.locale.languageCode})',
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: AppLocalizations.supportedLocales
                    .map(
                      (locale) => SizedBox(
                        height: 50,
                        width: 100,
                        child: PrimaryButton(
                          text: locale.languageCode,
                          isDisabled: locale.languageCode ==
                              languageState.locale.languageCode,
                          onPressed: () => LanguageService.changeLanguage(
                              ref, locale.languageCode),
                        ),
                      ),
                    )
                    .toList()),
          ],
        ));
  }
}
