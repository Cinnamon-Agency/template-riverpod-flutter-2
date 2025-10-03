import 'package:cinnamon_riverpod_2/firebase_options.dart';
import 'package:cinnamon_riverpod_2/infra/language/language_provider.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:cinnamon_riverpod_2/l10n/app_localizations.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:cinnamon_riverpod_2/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  await _prepareApp();

  runApp(
    const ProviderScope(
      child: TripFinder(),
    ),
  );
}

Future<void> _prepareApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load enviroment variables from ..env file
  await dotenv.load();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

class TripFinder extends ConsumerStatefulWidget {
  const TripFinder({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TripFinderState();
}

class _TripFinderState extends ConsumerState<TripFinder> {

  @override
  void initState() {
    super.initState();
    // Initialize storage and language after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await ref.read(localStorageServiceProvider).init();
     await ref.read(languageProvider.notifier).initializeLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Set the color of the system status bar, according to the current theme
    SystemChrome.setSystemUIOverlayStyle(MediaQuery.of(context).platformBrightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    final languageState = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'Trip Finder',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageState.locale,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
    );
  }


}
