import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/ui/common/artwork_component.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_album_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';
import 'package:sunrisescrob/ui/detail/component/track_title.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tags_component.dart';

class TrackContentComponent extends StatelessWidget {
  final Track? track;
  final String imageUrl;
  final String imageKey;

  const TrackContentComponent({
    super.key,
    required this.track,
    required this.imageKey,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: imageKey,
            child: ArtworkSquareComponent(
              imageUrl: imageUrl,
              size: double.infinity,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          if (track != null) _TrackDescriptionContent(track: track!)
        ],
      ),
    );
  }
}

class _TrackDescriptionContent extends StatelessWidget {
  final Track _track;

  const _TrackDescriptionContent({
    required Track track,
  }) : _track = track;

  @override
  Widget build(BuildContext context) {
    TrackAlbum? album = _track.album;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: SizedBox(
            width: double.infinity,
            child: TrackTitle(
              track: _track.artist.name,
              artist: _track.name,
            ),
          ),
        ),
        TrackMetadata(
          listeners: _track.listeners,
          playcount: _track.playcount,
          userPlaycount: _track.userPlayCount,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Divider(),
        ),
        if (album != null)
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: TrackAlbumComponent(
              album: album,
            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ChartTagsCarousel(tags: _track.tags),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        if (_track.wiki != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: double.infinity,
              child: WikiComponent(
                title: _track.name,
                wiki: _track.wiki!,
                url: _track.url,
              ),
            ),
          ),
        const Padding(
          padding: EdgeInsets.only(top: 24),
        ),
      ],
    );
  }
}
