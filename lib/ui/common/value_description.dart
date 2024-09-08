import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/presentation/int_representation.dart';

class ValueDescription extends StatelessWidget {
  final String value;
  final String label;

  const ValueDescription({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          IntRepresentation.toReadableValue(value),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
