import 'package:error_handling_and_logging/src/exceptions/release_mode_error_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../constants/testing.dart';
import 'debug_error_screen.dart';

/// class that takes care of handling all fatal (global) errors
class ErrorLogger {
  /// log error and displays an error screen
  void logAndDisplayGlobalError({
    required Object? error,
    required StackTrace? stack,
  }) {
    // log the global error or exception as "fatal" with error logger
    logErrorOrException(error: error, stack: stack, isFatal: true);

    // replace the current screen with the fatal error screen
    moveToErrorScreen(error, stack);
  }

  /// replacing the current screen with a fatal error screen
  void moveToErrorScreen(Object? error, StackTrace? stack) async {
    final context = navigatorKey.currentContext;
    // do nothing if there is no BuildContext
    if (context == null) {
      return;
    }
    // this is required in case the error is a build phase error
    // so that the widget build can fail properly before navigating
    await Future.microtask(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            // return different screens based on mode
            return kReleaseMode
                ? const ReleaseModeErrorScreen()
                : DebugErrorScreen(
                    error: error,
                    stack: stack,
                  );
          },
        ),
      );
    });
  }

  /// logs an error (unknown) or AppException (defined by sealed class)
  void logErrorOrException({
    required Object? error,
    required StackTrace? stack,
    required bool isFatal,
  }) {
    // exit if the error is null or the app is a web app (doesn't work with crashlytics)
    // or the app is not in release mode (no need to log while developing)
    if (error == null || kIsWeb || (!kReleaseMode && testLogging == false)) {
      return;
    }

    // otherwise log error with crashlytics
    // note: all non-fatal exceptions get stored and send with the next fatal one
    // (up to 8 total)
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: isFatal);
  }
}

final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});
