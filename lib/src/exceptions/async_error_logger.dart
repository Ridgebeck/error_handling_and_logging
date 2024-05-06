import 'package:error_handling_and_logging/src/exceptions/app_exception.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_logger.dart';

/// Error logger class to keep track of all AsyncError states that are set
/// by the controllers in the app
class AsyncErrorLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final error = _findError(newValue);
    // exit if there was no error found
    if (error == null) {
      return;
    }
    // dump error to console in debug mode
    debugPrint('${error.error}\n${error.stackTrace}');
    // get error logger from provider
    final errorLogger = container.read(errorLoggerProvider);
    // consider everything that is NOT an AppException as fatal
    final isFatal = error.error is! AppException;
    // log error or exception
    errorLogger.logErrorOrException(
      error: error.error,
      stack: error.stackTrace,
      isFatal: isFatal,
    );
  }

  AsyncError<dynamic>? _findError(Object? value) {
    if (value is AsyncError) {
      return value;
    } else {
      return null;
    }
  }
}
