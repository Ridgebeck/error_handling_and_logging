import 'package:flutter/material.dart';

/// error screen that shows the user something unforeseen happened
class ReleaseModeErrorScreen extends StatelessWidget {
  const ReleaseModeErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.red,
        child: const Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
