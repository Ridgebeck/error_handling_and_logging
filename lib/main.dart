import 'dart:async';

import 'package:error_handling_and_logging/src/app_bootstrap.dart';
import 'package:error_handling_and_logging/src/app_bootstrap_fake.dart';
import 'package:error_handling_and_logging/src/exceptions/error_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

/// async main to allow initializations
Future<void> main() async {
  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  // create provider container that contains all providers
  // and add observer to log async errors (caught by AsyncValue.guard inside notifiers)
  final container = await appBootstrap.createFakesProviderContainer();

  // this helps to catch otherwise uncatchable async dart errors
  // that bubble up to the top uncaught
  runZonedGuarded(() async {
    // this has to be inside the zone to catch the zone errors (async errors) properly
    WidgetsFlutterBinding.ensureInitialized();
    // initialize firebase to use crashlytics
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // create root widget from container and setup error handlers
    // for flutter and platform errors
    final root = appBootstrap.createRootWidget(container: container);
    // run the app with the created root widget
    // ignore: missing_provider_scope
    return runApp(root);
  }, (error, stack) {
    // handle all errors that are not otherwise handled
    debugPrint('ZONED ERROR');
    // e.g. async dart errors
    final errorLogger = container.read(errorLoggerProvider);
    errorLogger.logAndDisplayGlobalError(
      error: error,
      stack: stack,
    );
  });
}
