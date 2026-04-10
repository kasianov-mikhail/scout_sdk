import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'scout_sdk_platform_interface.dart';

class MethodChannelScoutSdk extends ScoutSdkPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('scout_sdk');

  @override
  Future<void> setup({required String containerId}) async {
    await methodChannel.invokeMethod('setup', {'containerId': containerId});
  }

  @override
  Future<void> showDashboard({required String containerId}) async {
    await methodChannel.invokeMethod('showDashboard', {
      'containerId': containerId,
    });
  }
}
