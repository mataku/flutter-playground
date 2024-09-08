import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_title_component.dart';
import 'package:sunrisescrob/ui/detail/component/album_tracks_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tags_component.dart';

class AlbumContent extends StatelessWidget {
  final Album? _album;
  final String _imageUrl;
  final String _imageKey;

  const AlbumContent({
    super.key,
    required Album? album,
    required String imageUrl,
    required String imageKey,
  })  : _album = album,
        _imageUrl = imageUrl,
        _imageKey = imageKey;

  @override
  Widget build(BuildContext context) {
    final wiki = _album?.wiki;
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Hero(
            tag: _imageKey,
            child: ArtworkSquareComponent(
              imageUrl: _imageUrl,
              size: double.infinity,
            ),
          ),
        ),
        if (_album != null)
          SliverToBoxAdapter(
            child: AlbumTitleComponent(
              albumName: _album.name,
              artist: _album.artist,
            ),
          ),
        if (_album != null)
          SliverToBoxAdapter(
            child: TrackMetadata(
              listeners: _album.listeners,
              playcount: _album.playcount,
              userPlaycount: _album.userplaycount.toString(),
            ),
          ),
        if (_album != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ChartTagsCarousel(
                  tags: _album.tags,
                ),
              ),
            ),
          ),
        if (_album != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Divider(
                color: theme.colorScheme.onSecondary.withAlpha(128),
              ),
            ),
          ),
        if (_album != null)
          SliverToBoxAdapter(
            child: AlbumTracksComponent(
              albumTracks: _album.tracks,
            ),
          ),
        if (_album != null && wiki != null)
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
