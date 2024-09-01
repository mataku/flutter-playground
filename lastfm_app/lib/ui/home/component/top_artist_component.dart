import 'package:flutter/material.dart';
import 'package:state_app/ui/common/artwork_component.dart';

class TopArtistComponent extends StatelessWidget {
  final String imageUrl;
  final String artist;
  final String playcount;

  const TopArtistComponent({
    super.key,
    required this.imageUrl,
    required this.artist,
    required this.playcount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ArtworkSquareComponent(
              imageUrl: imageUrl,
              size: double.infinity,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Text(
            artist,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "$playcount times",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
