import 'package:flutter/material.dart';
import 'package:sunrisescrob/ui/detail/component/track_title.dart';

class AlbumTitleComponent extends StatelessWidget {
  final String albumName;
  final String artist;

  const AlbumTitleComponent({
    super.key,
    required this.albumName,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: SizedBox(
        width: double.infinity,
        child: TrackTitle(
          track: albumName,
          artist: artist,
        ),
      ),
    );
  }
}
