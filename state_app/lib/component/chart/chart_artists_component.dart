import 'package:flutter/material.dart';
import 'package:state_app/component/chart/chart_cell.dart';
import 'package:state_app/component/header.dart';
import 'package:state_app/model/chart_artist.dart';

class ChartArtistsComponent extends StatelessWidget {
  final List<ChartArtist> artists;

  const ChartArtistsComponent({super.key, required this.artists});

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
            title: 'Top Artists',
          ),
          Flexible(
            child: _ChartArtistsCarousel(
              artists: artists,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartArtistsCarousel extends StatelessWidget {
  final List<ChartArtist> artists;

  const _ChartArtistsCarousel({required this.artists});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(left: 16, right: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ChartCell(
          artworkUrl: null,
          title: artist.name,
          subtitle: "",
        );
      },
      itemCount: artists.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }
}
