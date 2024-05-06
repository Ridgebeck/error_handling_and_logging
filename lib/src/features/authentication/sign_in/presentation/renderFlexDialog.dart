import 'package:flutter/material.dart';

class RenderFlexDialog extends StatelessWidget {
  const RenderFlexDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('A dialog'),
      // some way to long content that causes a RenderFlex overflow error
      content: Column(
        children: [
          Container(
            height: 1000,
            width: 1000,
            color: Colors.purple,
          )
        ],
      ),
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
