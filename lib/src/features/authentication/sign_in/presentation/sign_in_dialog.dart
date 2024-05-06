// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'sign_in_controller.dart';
//
// class SignInDialog extends ConsumerWidget {
//   const SignInDialog({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final demoControllerState = ref.watch(demoControllerProvider);
//
//     return AlertDialog(
//       title: const Text('Sign In'),
//       content: const Text('Sign in test'),
//       actions: [
//         ElevatedButton(
//           onPressed: demoControllerState.isLoading
//               ? null
//               : () {
//                   Navigator.of(context).pop();
//                 },
//           child: const Text('cancel'),
//         ),
//         ElevatedButton(
//           onPressed: demoControllerState.isLoading
//               ? null
//               : () {
//                   ref.read(demoControllerProvider.notifier).signInWithEmailAndPassword(true);
//                 },
//           child: const Text('ok'),
//         ),
//       ],
//     );
//   }
// }
