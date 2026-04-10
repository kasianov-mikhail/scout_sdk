import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'scout_sdk_method_channel.dart';

abstract class ScoutSdkPlatform extends PlatformInterface {
  ScoutSdkPlatform() : super(token: _token);

  static final Object _token = Object();
  static ScoutSdkPlatform _instance = MethodChannelScoutSdk();

  static ScoutSdkPlatform get instance => _instance;

  static set instance(ScoutSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setup({required String containerId}) {
    throw UnimplementedError('setup() has not been implemented.');
  }

  Future<void> showDashboard({required String containerId}) {
    throw UnimplementedError('showDashboard() has not been implemented.');
  }
}
