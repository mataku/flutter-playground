import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_title_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_tracks_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tags_component.dart';

class AlbumContent extends StatelessWidget {
  final Album _album;
  final String _imageUrl;
  final String _imageKey;

  const AlbumContent({
    super.key,
    required Album album,
    required String imageUrl,
    required String imageKey,
  })  : _album = album,
        _imageUrl = imageUrl,
        _imageKey = imageKey;

  @override
  Widget build(BuildContext context) {
    final wiki = _album.wiki;
    final theme = Theme.of(context);
    return Column(
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ChartTagsCarousel(
              tags: _album.tags,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Divider(
            color: theme.colorScheme.onSecondary.withAlpha(128),
          ),
        ),
        AlbumTracksComponent(
          albumTracks: _album.tracks,
        ),
        if (wiki != null)
          SliverToBoxAdapter(
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
