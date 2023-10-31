import 'package:cinnamon_riverpod_2/features/planner/trips/planner_home_page.dart';
import 'package:cinnamon_riverpod_2/features/account/view/account_page.dart';
import 'package:cinnamon_riverpod_2/features/home/controller/home_controller.dart';
import 'package:cinnamon_riverpod_2/features/home/controller/home_state.dart';
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
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.travel_explore_outlined),
            icon: Icon(Icons.travel_explore),
            label: 'Trips',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.people),
            icon: Icon(Icons.people_outline),
            label: 'Friends',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.manage_accounts_outlined),
            icon: Icon(Icons.school_outlined),
            label: 'Account',
          ),
        ],
      ),
      body: SafeArea(
        child: <Widget>[
          const PlannerHomePage(),
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text('Page 2'),
          ),
          const AccountPage(),
        ][state.page.index],
      ),
    );
  }
}
