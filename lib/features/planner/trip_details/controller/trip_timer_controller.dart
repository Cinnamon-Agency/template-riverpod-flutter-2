import 'dart:async';
import 'dart:html';

import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_timer_state.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripTimerControllerProvider =
    NotifierProvider.autoDispose.family<TripTimerController, TripTimerState, TripLocation>(
  () => TripTimerController(),
);

class TripTimerController extends AutoDisposeFamilyNotifier<TripTimerState, TripLocation> {
  Timer? _ticker;
  late KeepAliveLink link;

  LocalStorageService get _storageService => ref.read(localStorageServiceProvider);

  @override
  TripTimerState build(TripLocation tripLocation) {
    link = ref.keepAlive();

    _ticker?.cancel();

    ref.onDispose(() {
      _ticker?.cancel();
    });

    Future(() {
      _setupTicker();
    });

    final previousDuration =
        int.tryParse(_storageService.getValue(LocalStorageKeys.tripTimer(tripLocation.id)).toString());

    return TripTimerState(
      timeUp: false,
      currentLocation: tripLocation,
      remainingTime: previousDuration == null ? tripLocation.duration : Duration(seconds: previousDuration),
    );
  }

  void _setupTicker() {
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final duration = state.remainingTime - const Duration(seconds: 1);
        await _storageService.setValue(
            key: LocalStorageKeys.tripTimer(state.currentLocation.id), data: duration.inSeconds.toString());
        if (duration.inSeconds <= 0) {
          timer.cancel();
          state = state.copyWith(remainingTime: Duration.zero, timeUp: true);
        } else {
          state = state.copyWith(remainingTime: duration);
        }
      },
    );
  }

  void dispose() {
    link.close();
  }
}
