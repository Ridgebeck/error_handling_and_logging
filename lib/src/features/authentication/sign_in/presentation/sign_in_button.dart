import 'package:error_handling_and_logging/src/features/authentication/sign_in/presentation/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({
    super.key,
    required this.success,
  });
  final bool success;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // keep track of sign in state (state of controller)
    final signInState = ref.watch(signInControllerProvider);
    return ElevatedButton(
      // deactivate button while loading
      onPressed: signInState.isLoading
          ? null
          : () async {
              await ref.read(signInControllerProvider.notifier).signInWithEmailAndPassword(success);
            },
      child: success ? const Text('Sign In Success') : const Text('Sign In Fail'),
    );
  }
}
