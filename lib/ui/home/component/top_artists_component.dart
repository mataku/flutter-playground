import 'package:flutter/material.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/user/top_artist.dart';
import 'package:sunrisescrob/ui/home/component/top_artist_component.dart';

class TopArtistsComponent extends StatelessWidget {
  final List<TopArtist> artists;
  final bool hasMore;
  final bool isLoading;
  final VoidCallback fetchMore;

  static const _scrollThreshold = 0.75;

  const TopArtistsComponent({
    super.key,
    required this.artists,
    required this.hasMore,
    required this.isLoading,
    required this.fetchMore,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: CustomScrollView(
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
      ),
      onNotification: (ScrollNotification scrollNotification) {
        if (!hasMore) return false;
        if (scrollNotification is ScrollEndNotification) {
          final scrollProportion = scrollNotification.metrics.pixels /
              scrollNotification.metrics.maxScrollExtent;
          if (hasMore && !isLoading && scrollProportion > _scrollThreshold) {
            fetchMore();
          }
        }
        return false;
      },
    );
  }
}
