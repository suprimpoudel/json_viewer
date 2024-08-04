import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final dynamic error;

  const ErrorDialog({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(error.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "OK",
          ),
        ),
      ],
    );
  }
}
