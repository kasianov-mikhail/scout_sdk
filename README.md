# scout_sdk

[![CI](https://github.com/kasianov-mikhail/scout_sdk/actions/workflows/ci.yml/badge.svg)](https://github.com/kasianov-mikhail/scout_sdk/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/scout_sdk.svg)](https://pub.dev/packages/scout_sdk)
[![license](https://img.shields.io/github/license/kasianov-mikhail/scout_sdk.svg)](https://github.com/kasianov-mikhail/scout_sdk/blob/main/LICENSE)

Flutter wrapper for [Scout](https://github.com/kasianov-mikhail/scout) — an iOS analytics framework providing logging, metrics, crash reporting, and session tracking backed by Apple's CloudKit.

## Platform Support

| iOS | Android |
|:---:|:-------:|
| Yes |   No    |

## Requirements

- iOS 16.0+
- Flutter 3.24+ (Swift Package Manager support)
- A CloudKit container configured in your Apple Developer account

## Installation

```yaml
dependencies:
  scout_sdk: ^0.1.0
```

This package depends on [swift_log_bridge](https://pub.dev/packages/swift_log_bridge) and [swift_metrics_bridge](https://pub.dev/packages/swift_metrics_bridge), which are included automatically.

### iOS Setup

1. Enable **CloudKit** and **Push Notifications** capabilities in Xcode
2. Create a CloudKit container (e.g., `iCloud.com.yourcompany.yourapp`)

## Usage

### Initialize

```dart
import 'package:scout_sdk/scout_sdk.dart';

await Scout.setup(containerId: 'iCloud.com.yourcompany.yourapp');
```

### Logging

After `Scout.setup()`, all logging is persisted to CloudKit via Scout's swift-log backend.

```dart
const logger = Logger('MyApp');

await logger.info('User signed in');
await logger.error('Request failed', metadata: {'endpoint': '/api/users'});
```

### Metrics

After `Scout.setup()`, all metrics are persisted to CloudKit via Scout's swift-metrics backend.

```dart
const counter = Counter('button_taps');
await counter.increment();

const timer = MetricsTimer('api_latency');
await timer.record(Duration(milliseconds: 250));
```

### Dashboard

```dart
await Scout.showDashboard(containerId: 'iCloud.com.yourcompany.yourapp');
```

## Architecture

```
scout_sdk
├── swift_log_bridge      (swift-log wrapper)
└── swift_metrics_bridge   (swift-metrics wrapper)
```

`scout_sdk` configures Scout as the backend for both swift-log and swift-metrics. The logging and metrics packages can also be used independently with other backends.
