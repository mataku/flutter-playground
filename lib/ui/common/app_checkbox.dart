import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;

  const AppCheckbox({
    super.key,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // used custom component instead of Checkbox to customize padding

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: checked ? Colors.blue : Colors.transparent,
        border: checked
            ? Border.all(
                color: Colors.blue,
              )
            : Border.all(
                color: theme.colorScheme.onSecondary,
              ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: checked
              ? const Icon(
                  Icons.check,
                  size: 20,
                )
              : const Icon(
                  Icons.check,
                  color: Colors.transparent,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
