import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String _text;
  final VoidCallback _onTap;

  const AppButton({
    super.key,
    required String text,
    required VoidCallback onTap,
  })  : _text = text,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return SizedBox(
        width: double.infinity,
        child: CupertinoButton(
          onPressed: _onTap,
          color: CupertinoColors.systemBlue,
          child: Text(_text),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: _onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }
}
