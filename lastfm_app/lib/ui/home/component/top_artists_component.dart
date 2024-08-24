import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/user/top_artist.dart';
import 'package:state_app/ui/home/component/top_artist_component.dart';

class TopArtistsComponent extends StatelessWidget {
  final List<TopArtist> artists;
  final bool hasMore;
  final ScrollController scrollController;

  const TopArtistsComponent({
    super.key,
    required this.artists,
    required this.hasMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: artists.length,
        itemBuilder: (BuildContext context, int index) {
          final artist = artists[index];
          return TopArtistComponent(
            imageUrl: artist.images.imageUrl() ?? '',
            artist: artist.name,
            playcount: artist.playcount,
          );
        },
        controller: scrollController,
      ),
    );
  }
}
