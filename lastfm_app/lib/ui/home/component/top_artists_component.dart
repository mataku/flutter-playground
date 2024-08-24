import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/user/top_artist.dart';
import 'package:state_app/ui/home/component/top_artist_component.dart';

class TopArtistsComponent extends StatelessWidget {
  final List<TopArtist> artists;
  final bool hasMore;
  final bool isLoading;

  final ScrollController scrollController;

  const TopArtistsComponent({
    super.key,
    required this.artists,
    required this.hasMore,
    required this.isLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.only(top: 12),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
            mainAxisSpacing: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final artist = artists[index];
              return TopArtistComponent(
                imageUrl: artist.images.imageUrl() ?? '',
                artist: artist.name,
                playcount: artist.playcount,
              );
            },
            childCount: artists.length,
          ),
        ),
        if (artists.isNotEmpty && isLoading)
          const SliverToBoxAdapter(
            child: CircularProgressIndicator(),
          ),
        if (artists.isNotEmpty && !isLoading)
          const SliverPadding(padding: EdgeInsets.only(top: 24)),
      ],
      controller: scrollController,
    );
  }
}
