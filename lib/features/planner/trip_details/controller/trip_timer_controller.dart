import 'dart:async';
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
  late KeepAliveLink _link;

  LocalStorageService get _storageService => ref.read(localStorageServiceProvider);

  @override
  TripTimerState build(TripLocation arg) {
    _link = ref.keepAlive();

    _ticker?.cancel();

    ref.onDispose(() {
      _ticker?.cancel();
    });

    Future(() {
      _setupTicker();
    });

    Duration remainingTime = arg.duration;

    final timerStartTime = _storageService.getValue(LocalStorageKeys.tripTimer(arg.id));

    if (timerStartTime != null) {
      final previousTimerStart = DateTime.parse(timerStartTime);

      final diff = previousTimerStart.difference(DateTime.now());

      if (diff < arg.duration) {
        remainingTime = DateTime.now().difference(previousTimerStart.add(arg.duration));
      }
    } else {
      _storageService.setValue(
          key: LocalStorageKeys.tripTimer(state.currentLocation.id), data: DateTime.now().toIso8601String());
    }

    return TripTimerState(
      timeUp: false,
      currentLocation: arg,
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

  void dispose() {
    _link.close();
  }
}
