import 'package:error_handling_and_logging/src/exceptions/async_value_ui.dart';
import 'package:error_handling_and_logging/src/features/authentication/sign_in/presentation/renderFlexDialog.dart';
import 'package:error_handling_and_logging/src/features/authentication/sign_in/presentation/sign_in_button.dart';
import 'package:error_handling_and_logging/src/features/authentication/sign_in/presentation/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../exceptions/app_exception.dart';
import '../data/fake_auth_repository.dart';
import 'error_dialog.dart';

class DemoPage extends ConsumerWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen to changing states of the controller and show alert when an error occurs
    ref.listen(signInControllerProvider, (_, state) => state.showAlertDialogOnError(context));

    final dataValue = ref.watch(dataProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ErrorDialog();
                    });
              },
              child: const Text('Widget Build Error'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const RenderFlexDialog();
                    });
              },
              child: const Text('RenderFlex overflowed'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                throw PlatformException(code: 'Platform Error');
                //await ref.read(authRepositoryProvider).throwAnError();
              },
              child: const Text('Platform Error'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  throw StateError('Unhandled Error!');
                });
              },
              child: const Text('Unhandled Error'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                throw Exception('Unhandled Exception!');
              },
              child: const Text('Unhandled Exception'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                throw UserNotFoundException();
              },
              child: const Text('Unhandled AppException'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                throw Exception('Unhandled Async Exception!');
              },
              child: const Text('Unhandled Async Exception'),
            ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () async {
            //     await ref.read(fakeAuthRepositoryProvider).throwAnError();
            //   },
            //   child: const Text('repo error'),
            // ),
            const SizedBox(height: 20),
            SizedBox(
              width: 50,
              height: 50,
              child: AsyncValueWidget(
                value: ref.watch(signInControllerProvider),
                data: (isSignedIn) => !isSignedIn
                    ? const Text('Please Sign In')
                    : const Icon(Icons.check, color: Colors.green),
              ),
            ),
            const SignInButton(success: true),
            const SignInButton(success: false),
            // const SizedBox(height: 20),
            // Container(
            //   height: 200,
            //   color: Colors.blue,
            //   child: Center(
            //     child: AsyncValueWidget(
            //       value: dataValue,
            //       data: (value) => Text(value),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const Text('Fake Sign in:'),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return const SignInDialog();
            //         });
            //   },
            //   child: const Text('open Dialog'),
            // ),
          ],
        ),
      ),
    );
  }
}
