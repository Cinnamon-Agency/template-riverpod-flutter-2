import 'dart:async';
import 'package:cinnamon_riverpod_2/features/planner/trip_details/controller/trip_timer_state.dart';
import 'package:cinnamon_riverpod_2/helpers/extensions/ref_extension.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';
import 'package:cinnamon_riverpod_2/infra/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tripTimerControllerProvider =
    NotifierProvider.autoDispose.family<TripTimerController, TripTimerState, (String, TripLocation)>(
  () => TripTimerController(),
);

class TripTimerController extends AutoDisposeFamilyNotifier<TripTimerState, (String, TripLocation)> {
  Timer? _ticker;

  LocalStorageService get _storageService => ref.read(localStorageServiceProvider);

  @override
  TripTimerState build((String, TripLocation) arg) {
    // keeping alive for 2 seconds because this provider is used in a if condition
    ref.keepAliveBriefly(seconds: 2);

    _ticker?.cancel();

    ref.onDispose(() {
      _ticker?.cancel();
      cleanUpFromStorage(arg.$2.id);
    });

    Duration remainingTime = arg.$2.duration;

    final timerStartTime = _storageService.getValue(LocalStorageKeys.tripTimer(arg.$2.id));
    if (timerStartTime != null) {
      final previousTimerStart = DateTime.parse(timerStartTime);

      final diff = DateTime.now().difference(previousTimerStart);

      if (diff < arg.$2.duration) {
        remainingTime = previousTimerStart.add(arg.$2.duration).difference(DateTime.now());
      }
    } else {
      _storageService.setValue(key: LocalStorageKeys.tripTimer(arg.$2.id), data: DateTime.now().toIso8601String());
    }
    Future(() {
      _setupTicker();
    });

    return TripTimerState(
      timeUp: false,
      currentLocation: arg.$2,
      remainingTime: remainingTime,
    );
  }

  void _setupTicker() {
    _ticker = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final duration = state.remainingTime - const Duration(seconds: 1);

        if (duration.inSeconds <= 0) {
          timer.cancel();
          state = state.copyWith(remainingTime: Duration.zero, timeUp: true);
        } else {
          state = state.copyWith(remainingTime: duration);
        }
      },
    );
  }

  void cleanUpFromStorage(String locationId) {
    _storageService.deleteValue(LocalStorageKeys.tripTimer(locationId));
  }
}
