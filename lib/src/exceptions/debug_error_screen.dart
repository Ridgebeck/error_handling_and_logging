import 'package:flutter/material.dart';

import 'app_exception.dart';

/// error screen that shows error and stack details for debugging
class DebugErrorScreen extends StatelessWidget {
  const DebugErrorScreen({
    super.key,
    this.error,
    this.stack,
  });

  final Object? error;
  final StackTrace? stack;

  @override
  Widget build(BuildContext context) {
    final isException = error is Exception;
    final isAppException = error is AppException;
    return Scaffold(
      backgroundColor: isAppException
          ? Colors.purple
          : isException
              ? Colors.orange
              : Colors.red,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                isAppException
                    ? const Text('APP EXCEPTION')
                    : isException
                        ? const Text('EXCEPTION')
                        : const Text('ERROR'),
                const SizedBox(height: 20),
                Text('$error'),
                const SizedBox(height: 20),
                Text('STACK: $stack'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
