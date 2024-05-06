import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_bootstrap.dart';
import 'exceptions/async_error_logger.dart';
import 'features/authentication/sign_in/data/auth_repository.dart';
import 'features/authentication/sign_in/data/fake_auth_repository.dart';

/// Extension methods specific for the "fakes" project configuration
extension AppBootstrapFakes on AppBootstrap {
  /// creates a provider container with fake providers
  Future<ProviderContainer> createFakesProviderContainer() async {
    final authRepository = FakeAuthRepository();
    // add other repos and services here

    return ProviderContainer(
      overrides: [
        // repositories
        authRepositoryProvider.overrideWithValue(authRepository),
        // overwrite other repos and services here
      ],
      // logg all errors caught from the async notifiers (controllers)
      observers: [AsyncErrorLogger()],
    );
  }
}
