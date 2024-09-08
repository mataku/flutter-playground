import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/model/presentation/int_representation.dart';

class AlbumTracksComponent extends StatelessWidget {
  final List<AlbumTrack> _albumTracks;

  const AlbumTracksComponent({
    super.key,
    required List<AlbumTrack> albumTracks,
  }) : _albumTracks = albumTracks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'Track list',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Column(
          children: _albumTracks
              .map((track) => _AlbumTrackComponent(albumTrack: track))
              .toList(),
        )
      ],
    );
  }
}

class _AlbumTrackComponent extends StatelessWidget {
  final AlbumTrack _albumTrack;

  const _AlbumTrackComponent({
    required AlbumTrack albumTrack,
  }) : _albumTrack = albumTrack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _albumTrack.position.toString(),
              style: TextStyle(
                color: theme.colorScheme.onSecondary,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
            ),
            Expanded(
              child: Text(
                _albumTrack.name,
              ),
            ),
            if (_albumTrack.duration != 0)
              Text(IntRepresentation.toReadableTime(_albumTrack.duration))
          ],
        ),
      ),
    );
  }
}
