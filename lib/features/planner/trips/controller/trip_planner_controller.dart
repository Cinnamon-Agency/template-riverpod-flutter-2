import 'dart:async';
import 'package:cinnamon_riverpod_2/features/planner/trips/controller/trip_planner_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/infra/planner/repository/trip_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripPlannerControllerProvider = AutoDisposeAsyncNotifierProvider<TripPlannerController, TripPlannerState>(() {
  return TripPlannerController();
});

class TripPlannerController extends AutoDisposeAsyncNotifier<TripPlannerState> {
  StreamSubscription<List<TripItinerary>>? _trips;

  TripRepository get _tripRepo => ref.read(tripRepositoryProvider);

  @override
  FutureOr<TripPlannerState> build() async {
    ref.keepAlive();

    ref.onDispose(() {
      _trips?.cancel();
    });

    Future<void>(() async {
      state = const AsyncLoading<TripPlannerState>();
      await _trips?.cancel();

      _trips = ref.watch(tripRepositoryProvider).getTripItineraries().listen((List<TripItinerary> event) {
        final currentItinerary = event.firstWhereOrNull((element) => element.isOngoing);
        final upcomingItineraries = event
            .where((element) => element.isUpcoming && !element.isOngoing && !element.hasEnded)
            .sortedBy((element) => element.startDate)
            .toList();
        final pastItineraries =
            event.where((element) => element.hasEnded).sortedBy((element) => element.startDate).toList();

        state = AsyncData<TripPlannerState>(
          TripPlannerState(
            currentItinerary: currentItinerary,
            upcomingItineraries: upcomingItineraries,
            pastItineraries: pastItineraries,
          ),
        );
      });
    });

    return const TripPlannerState(
      currentItinerary: null,
      upcomingItineraries: <TripItinerary>[],
      pastItineraries: <TripItinerary>[],
    );
  }

  Future<void> createMocked() async {
    await _tripRepo.createMocked();
  }
}
