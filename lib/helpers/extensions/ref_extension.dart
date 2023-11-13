import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension KeepAliveExtension on AutoDisposeRef {
  KeepAliveLink keepAliveBriefly({int seconds = 10}) {
    final link = keepAlive();
    Timer? timer;
    onDispose(() => timer?.cancel());
    onCancel(() => timer = Timer(Duration(seconds: seconds), () => link.close()));
    onResume(() => timer?.cancel());
    return link;
  }
}
