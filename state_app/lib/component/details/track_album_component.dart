import 'package:flutter/material.dart';
import 'package:state_app/component/artwork_component.dart';
import 'package:state_app/model/track.dart';

class TrackAlbumComponent extends StatelessWidget {
  final TrackAlbum album;

  const TrackAlbumComponent({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Album',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Row(
            children: [
              const ArtworkComponent(
                imageUrl: null,
                size: 96,
              ),
              const Padding(padding: EdgeInsets.only(left: 16)),
              AlbumTitleComponent(
                title: album.title,
                artist: album.artist,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AlbumTitleComponent extends StatelessWidget {
  final String title;
  final String artist;

  const AlbumTitleComponent({
    super.key,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          artist,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
