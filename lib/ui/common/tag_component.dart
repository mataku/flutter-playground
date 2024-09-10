import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/tag.dart';

class TagComponent extends StatelessWidget {
  final Tag tag;

  const TagComponent({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(tag.name),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: 0),
    );
  }
}
