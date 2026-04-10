import 'package:flutter/material.dart';
import 'package:scout_sdk/scout_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _containerId = 'iCloud.com.example.app';
  bool _isSetup = false;
  String _status = 'Not initialized';

  Future<void> _setup() async {
    try {
      await Scout.setup(containerId: _containerId);
      setState(() {
        _isSetup = true;
        _status = 'Scout initialized';
      });
    } catch (e) {
      setState(() => _status = 'Setup failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Scout Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _setup,
                child: const Text('Initialize Scout'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isSetup
                    ? () {
                        const logger = Logger('Example');
                        logger.info('Button tapped');
                      }
                    : null,
                child: const Text('Log Message'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isSetup
                    ? () => const Counter('taps').increment()
                    : null,
                child: const Text('Increment Counter'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isSetup
                    ? () => Scout.showDashboard(containerId: _containerId)
                    : null,
                child: const Text('Show Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
