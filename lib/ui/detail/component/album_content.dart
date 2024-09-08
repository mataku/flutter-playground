import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/ui/common/tag_list_component.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_title_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_tracks_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';

class AlbumContent extends StatelessWidget {
  final Album _album;

  const AlbumContent({
    super.key,
    required Album album,
  }) : _album = album;

  @override
  Widget build(BuildContext context) {
    final wiki = _album.wiki;
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AlbumTitleComponent(
          albumName: _album.name,
          artist: _album.artist,
        ),
        TrackMetadata(
          listeners: _album.listeners,
          playcount: _album.playcount,
          userPlaycount: _album.userplaycount.toString(),
        ),
        if (_album.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: TagListComponent(
                tags: _album.tags,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 15,
            right: 15,
          ),
          child: Divider(
            color: theme.colorScheme.onSecondary.withAlpha(128),
          ),
        ),
        AlbumTracksComponent(
          albumTracks: _album.tracks,
        ),
        if (wiki != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: WikiComponent(
              title: _album.name,
              wiki: wiki,
              url: _album.url,
            ),
          ),
      ],
    );
  }
}
