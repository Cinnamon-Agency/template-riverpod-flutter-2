import 'package:cinnamon_riverpod_2/firebase_options.dart';
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

class TripFinder extends StatelessWidget {
  const TripFinder({super.key});

  @override
  Widget build(BuildContext context) {
    // Set the color of the system status bar, according to the current theme
    SystemChrome.setSystemUIOverlayStyle(MediaQuery.of(context).platformBrightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    return MaterialApp.router(
      title: 'Trip Finder',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
    );
  }
}
