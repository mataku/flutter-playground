import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? description;
  final VoidCallback dismissOnTap;
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
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(description ?? ''),
        actions: [
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
