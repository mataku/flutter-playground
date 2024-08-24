import 'package:flutter/material.dart';
import 'package:state_app/ui/common/artwork_component.dart';

class TopAlbumComponent extends StatelessWidget {
  final String imageUrl;
  final String album;
  final String artist;
  final String playcount;

  const TopAlbumComponent({
    super.key,
    required this.imageUrl,
    required this.album,
    required this.artist,
    required this.playcount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
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
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
