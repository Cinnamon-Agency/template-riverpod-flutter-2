import 'package:cinnamon_riverpod_2/features/planner/trips/planner_home_page.dart';
import 'package:cinnamon_riverpod_2/features/account/view/account_page.dart';
import 'package:cinnamon_riverpod_2/features/home/controller/home_controller.dart';
import 'package:cinnamon_riverpod_2/features/home/controller/home_state.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeController controller = ref.read(homeControllerProvider.notifier);
    final HomeState state = ref.watch(homeControllerProvider);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          controller.selectPage(SelectedHomePage.values[index]);
        },
        selectedIndex: state.page.index,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(Icons.travel_explore_outlined),
            icon: const Icon(Icons.travel_explore),
            label: context.localization.trips,
          ),
          // NavigationDestination(
          //   selectedIcon: const Icon(Icons.people),
          //   icon: const Icon(Icons.people_outline),
          //   label: context.localization.friends,
          // ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.manage_accounts),
            icon: const Icon(Icons.manage_accounts_outlined),
            label: context.localization.account,
          ),
        ],
      ),
      body: SafeArea(
        child: <Widget>[
          const PlannerHomePage(),
          // Container(
          //   color: Colors.green,
          //   alignment: Alignment.center,
          //   child: const Text('Page 2'),
          // ),
          const AccountPage(),
        ][state.page.index],
      ),
    );
  }
}
