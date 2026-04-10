import 'scout_sdk_platform_interface.dart';

export 'package:swift_log_bridge/swift_log_bridge.dart';
export 'package:swift_metrics_bridge/swift_metrics_bridge.dart';

/// Flutter wrapper for the Scout analytics framework.
///
/// Scout provides logging, metrics, crash reporting, and session tracking
/// backed by Apple's CloudKit. iOS only.
///
/// Call [setup] before using logging or metrics. After setup, use [Logger]
/// from swift_log_bridge and [Counter]/[MetricsTimer] from
/// swift_metrics_bridge — they automatically route through Scout's backend.
class Scout {
  Scout._();

  /// Initialize Scout with a CloudKit container identifier.
  ///
  /// Must be called before logging or metrics will be persisted to CloudKit.
  static Future<void> setup({required String containerId}) {
    return ScoutSdkPlatform.instance.setup(containerId: containerId);
  }

  /// Present the native Scout SwiftUI dashboard.
  static Future<void> showDashboard({required String containerId}) {
    return ScoutSdkPlatform.instance.showDashboard(containerId: containerId);
  }
}
