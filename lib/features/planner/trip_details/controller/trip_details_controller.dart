import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeNotifierProvider<TripDetailsController, TripDetailsState> tripDetailsControllerProvider =
    NotifierProvider.autoDispose<TripDetailsController, TripDetailsState>(
  () => TripDetailsController(),
);

class TripDetailsController extends AutoDisposeNotifier<TripDetailsState> {
  @override
  TripDetailsState build() {
    return const TripDetailsState();
  }

  void selectLocation(String locationId) {
    state = state.copyWith(selectedLocationId: locationId);
  }
}
