import 'package:flutter/material.dart';
import 'package:sunrisescrob/router/router.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';

class TopAlbumComponent extends StatelessWidget {
  final String imageUrl;
  final String album;
  final String artist;
  final String playcount;
  final String imageKey;

  const TopAlbumComponent({
    super.key,
    required this.imageUrl,
    required this.album,
    required this.artist,
    required this.playcount,
    required this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        AlbumDetailRoute(
          album: album,
          artist: artist,
          imageUrl: imageUrl,
          imageKey: imageKey,
        ).go(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: imageKey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ArtworkSquareComponent(
                  imageUrl: imageUrl,
                  size: double.infinity,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Text(
              album,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
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
      ),
    );
  }
}
