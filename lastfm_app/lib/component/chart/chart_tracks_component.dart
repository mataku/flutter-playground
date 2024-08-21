import 'package:flutter/material.dart';
import 'package:state_app/component/chart/chart_cell.dart';
import 'package:state_app/component/header.dart';
import 'package:state_app/model/chart_track.dart';

class ChartTracksComponent extends StatelessWidget {
  final List<ChartTrack> tracks;

  const ChartTracksComponent({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'Top Tracks',
          ),
          Flexible(
            child: _ChartTracksCarousel(tracks: tracks),
          ),
        ],
      ),
    );
  }
}

class _ChartTracksCarousel extends StatelessWidget {
  final List<ChartTrack> tracks;

  const _ChartTracksCarousel({required this.tracks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return ChartCell(
          artworkUrl: null,
          title: track.name,
          subtitle: track.artist.name,
        );
      },
      itemCount: tracks.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }
}
