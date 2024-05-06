import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // an error occurs during the build phase of a widget
    throw FlutterError('Error while building a dialog.');

    return AlertDialog(
      title: const Text('A dialog'),
      content: const Text('Some content of a dialog'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('cancel'),
        ),
      ],
    );
  }
}
