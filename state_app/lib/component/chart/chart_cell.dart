import 'package:flutter/material.dart';
import 'package:state_app/component/artwork_component.dart';

class ChartCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? artworkUrl;

  const ChartCell(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.artworkUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ArtworkComponent(
            imageUrl: artworkUrl,
            size: 140,
          ),
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Flexible(
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
