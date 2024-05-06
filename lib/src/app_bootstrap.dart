import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'exceptions/error_logger.dart';

/// Helper class to initialize services and configure the error handlers
class AppBootstrap {
  /// Create the root widget that should be passed to [runApp].
  Widget createRootWidget({required ProviderContainer container}) {
    // Initialize any specific providers that need to be overwritten here

    // Register error handlers
    final errorLogger = container.read(errorLoggerProvider);
    _registerErrorHandlers(errorLogger);

    return UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    );
  }

  /// Register error handlers for flutter and platform errors
  void _registerErrorHandlers(ErrorLogger errorLogger) {
    // Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      // write error to console
      FlutterError.presentError(details);
      // check if it was a RenderFlex overflowed error
      if (details.exception.toString().contains('RenderFlex overflowed')) {
        // log the RenderFlex overflowed error as a "fatal" error
        // but don't show the error screen
        errorLogger.logErrorOrException(
          error: details.toString(), // add additional details to find widget
          stack: details.stack,
          isFatal: true,
        );
      } else {
        // log and display a "fatal" error screen for all other errors
        errorLogger.logAndDisplayGlobalError(
          error: details.exception,
          stack: details.stack,
        );
      }
    };

    // Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      // log and display error
      errorLogger.logAndDisplayGlobalError(
        error: error,
        stack: stack,
      );
      return true;
    };
  }
}
