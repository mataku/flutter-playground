import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/track.dart';
import 'package:sunrisescrob/ui/common/tag_list_component.dart';
import 'package:sunrisescrob/ui/common/wiki_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_album_component.dart';
import 'package:sunrisescrob/ui/detail/component/track_metadata.dart';
import 'package:sunrisescrob/ui/detail/component/track_title.dart';
import 'package:sunrisescrob/ui/discover/component/chart_tags_component.dart';

class TrackContentComponent extends StatelessWidget {
  final Track _track;

  const TrackContentComponent({
    super.key,
    required Track track,
  }) : _track = track;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    TrackAlbum? album = _track.album;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
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
        if (_track.tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: TagListComponent(tags: _track.tags),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 15,
            right: 15,
            bottom: 8,
          ),
          child: Divider(
            color: theme.colorScheme.onSecondary.withAlpha(128),
          ),
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
