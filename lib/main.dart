import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TripFinder());
}

class TripFinder extends StatelessWidget {
  const TripFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Trip Finder',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
