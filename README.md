<div align="center">

# Scout SDK

**iOS analytics for Flutter, backed by CloudKit**

[![CI](https://github.com/kasianov-mikhail/scout_sdk/actions/workflows/ci.yml/badge.svg)](https://github.com/kasianov-mikhail/scout_sdk/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/scout_sdk.svg)](https://pub.dev/packages/scout_sdk)
[![license](https://img.shields.io/github/license/kasianov-mikhail/scout_sdk.svg)](https://github.com/kasianov-mikhail/scout_sdk/blob/main/LICENSE)

Logging · Metrics · Crash Reporting · Session Tracking

[Getting Started](#getting-started) · [Logging](#logging) · [Metrics](#metrics) · [Dashboard](#dashboard)

</div>

<br>

Flutter wrapper for [Scout](https://github.com/kasianov-mikhail/scout) — an iOS analytics framework that persists logs, metrics, crash reports, and sessions to Apple's CloudKit.

> [!NOTE]
> iOS only. Requires iOS 16+ and Flutter 3.24+.

## Getting Started

```yaml
dependencies:
  scout_sdk: ^0.1.0
```

This package includes [swift_log_bridge](https://pub.dev/packages/swift_log_bridge) and [swift_metrics_bridge](https://pub.dev/packages/swift_metrics_bridge) automatically.

Enable **CloudKit** and **Push Notifications** capabilities in Xcode, then initialize:

```dart
import 'package:scout_sdk/scout_sdk.dart';

await Scout.setup(containerId: 'iCloud.com.yourcompany.yourapp');
```

## Logging

All logs are persisted to CloudKit via Scout's [swift-log](https://github.com/apple/swift-log) backend.

```dart
const logger = Logger('MyApp');

await logger.info('User signed in');
await logger.error('Request failed', metadata: {'endpoint': '/api/users'});
```

## Metrics

All metrics are persisted to CloudKit via Scout's [swift-metrics](https://github.com/apple/swift-metrics) backend.

```dart
const counter = Counter('button_taps');
await counter.increment();

const timer = MetricsTimer('api_latency');
await timer.record(Duration(milliseconds: 250));
```

## Dashboard

```dart
await Scout.showDashboard(containerId: 'iCloud.com.yourcompany.yourapp');
```

## Architecture

```
scout_sdk
├── swift_log_bridge
└── swift_metrics_bridge
```

The bridge packages can also be used independently with other backends.
