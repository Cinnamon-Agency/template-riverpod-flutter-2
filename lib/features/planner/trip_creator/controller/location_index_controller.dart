import 'package:flutter_riverpod/flutter_riverpod.dart';

final indexProvider = NotifierProvider<LocationIndex, int?>(LocationIndex.new);

class LocationIndex extends Notifier<int?> {

  @override
  int? build() {
    return null;
  }

  void setIndex(int? index) {
    state = index;
  }

}