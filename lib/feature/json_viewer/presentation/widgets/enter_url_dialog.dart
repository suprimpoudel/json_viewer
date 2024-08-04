import 'package:flutter/material.dart';

class EnterUrlDialog extends StatefulWidget {
  const EnterUrlDialog({super.key});

  @override
  State<EnterUrlDialog> createState() => _EnterUrlDialogState();
}

class _EnterUrlDialogState extends State<EnterUrlDialog> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter URL"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              label: Text("URL"),
              hintText: "Enter URL to fetch JSON value from",
              prefixIcon: Icon(Icons.language),
            ),
            maxLines: 1,
            minLines: 1,
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 4),
          Text(
            "#Note: Only GET requests are supported",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontStyle: FontStyle.italic,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _urlController.text),
          child: const Text("Fetch"),
        ),
      ],
    );
  }
}
