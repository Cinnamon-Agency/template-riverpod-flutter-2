import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final lifeCycleControllerProvider = NotifierProvider<LifeCycleController, AppLifecycleState>(() {
  return LifeCycleController();
});

class LifeCycleController extends Notifier<AppLifecycleState> {
  Map<Object, Function(AppLifecycleState)> _listeners = {};

  @override
  AppLifecycleState build() {
    return AppLifecycleState.resumed;
  }

  void updateState(AppLifecycleState state) {
    this.state = state;
    _listeners.forEach((_, fn) {
      fn(state);
    });
  }

  void addListener(tag, Function(AppLifecycleState state) listener) {
    _listeners[tag] = listener;
  }

  void removeListener(tag) {
    _listeners.remove(tag);
  }
}
