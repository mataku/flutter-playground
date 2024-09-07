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
      final theme = Theme.of(context);
      return AlertDialog(
        title: Text(title),
        content: Text(description ?? ''),
        actions: [
          if (dismissOnTap != null)
            TextButton(
              onPressed: dismissOnTap,
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          TextButton(
            onPressed: confirmOnTap,
            child: Text(
              'OK',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      );
    }
  }
}
