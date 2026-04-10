import 'package:flutter_test/flutter_test.dart';
import 'package:scout_sdk/scout_sdk.dart';
import 'package:scout_sdk/scout_sdk_platform_interface.dart';
import 'package:scout_sdk/scout_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockScoutSdkPlatform
    with MockPlatformInterfaceMixin
    implements ScoutSdkPlatform {
  String? lastSetupContainerId;
  String? lastDashboardContainerId;

  @override
  Future<void> setup({required String containerId}) async {
    lastSetupContainerId = containerId;
  }

  @override
  Future<void> showDashboard({required String containerId}) async {
    lastDashboardContainerId = containerId;
  }
}

void main() {
  final ScoutSdkPlatform initialPlatform = ScoutSdkPlatform.instance;

  test('MethodChannelScoutSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelScoutSdk>());
  });

  test('setup delegates to platform', () async {
    final mock = MockScoutSdkPlatform();
    ScoutSdkPlatform.instance = mock;

    await Scout.setup(containerId: 'iCloud.com.test');
    expect(mock.lastSetupContainerId, 'iCloud.com.test');
  });

  test('showDashboard delegates to platform', () async {
    final mock = MockScoutSdkPlatform();
    ScoutSdkPlatform.instance = mock;

    await Scout.showDashboard(containerId: 'iCloud.com.test');
    expect(mock.lastDashboardContainerId, 'iCloud.com.test');
  });
}
