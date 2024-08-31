import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback? dismissOnTap;
  final VoidCallback confirmOnTap;

  const AppDialog({
    super.key,
    required this.title,
    required this.description,
    required this.dismissOnTap,
    required this.confirmOnTap,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(description ?? ''),
        actions: [
          if (dismissOnTap != null)
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: dismissOnTap,
              textStyle: const TextStyle(color: CupertinoColors.systemBlue),
              child: const Text('Cancel'),
            ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: confirmOnTap,
            child: const Text('OK'),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(description ?? ''),
        actions: [
          if (dismissOnTap != null)
            GestureDetector(
              onTap: dismissOnTap,
              child: const Text('Cancel'),
            ),
          GestureDetector(
            onTap: confirmOnTap,
            child: const Text('OK'),
          ),
        ],
      );
    }
  }
}
