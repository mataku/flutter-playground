import 'package:flutter/material.dart';
import 'package:state_app/component/artwork_component.dart';
import 'package:state_app/component/chart/chart_tags_component.dart';
import 'package:state_app/component/details/track_album_component.dart';
import 'package:state_app/component/details/track_metadata.dart';
import 'package:state_app/component/details/track_title.dart';
import 'package:state_app/model/track.dart';

class TrackContentComponent extends StatelessWidget {
  final Track track;

  const TrackContentComponent({
    super.key,
    required this.track,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ArtworkSquareComponent(
            imageUrl: null,
            size: double.infinity,
          ),
          SizedBox(
            width: double.infinity,
            child: TrackTitle(
              track: track.artist.name,
              artist: track.name,
            ),
          ),
          TrackMetadata(
            listeners: track.listeners,
            playcount: track.playcount,
            userPlaycount: "100",
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Divider(),
          ),
          TrackAlbumComponent(
            album: track.album,
          ),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ChartTagsCarousel(tags: track.tags),
          )
        ],
      ),
    );
  }
}
