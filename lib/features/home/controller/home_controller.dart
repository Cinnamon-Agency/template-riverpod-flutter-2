import 'package:cinnamon_riverpod_2/features/home/controller/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = NotifierProvider<HomeController, HomeState>(() => HomeController());

class HomeController extends Notifier<HomeState> {
  @override
  HomeState build() {
    return const HomeState(page: SelectedHomePage.trips);
  }

  void selectPage(SelectedHomePage page) {
    state = HomeState(page: page);
  }
}
