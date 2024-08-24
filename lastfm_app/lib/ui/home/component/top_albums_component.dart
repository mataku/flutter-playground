import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/ui/home/component/top_album_component.dart';

class TopAlbumsComponent extends StatelessWidget {
  final List<TopAlbum> albums;
  final bool hasMore;
  final bool isLoading;
  final ScrollController scrollController;

  const TopAlbumsComponent({
    super.key,
    required this.albums,
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
            childAspectRatio: 0.72,
            mainAxisSpacing: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final album = albums[index];
              return TopAlbumComponent(
                imageUrl: album.images.imageUrl() ?? '',
                album: album.name,
                artist: album.artist.name,
                playcount: album.playcount,
              );
            },
            childCount: albums.length,
          ),
        ),
        if (albums.isNotEmpty && isLoading)
          const SliverToBoxAdapter(
            child: CircularProgressIndicator(),
          ),
        if (albums.isNotEmpty && !isLoading)
          const SliverPadding(padding: EdgeInsets.only(top: 24)),
      ],
      controller: scrollController,
    );
  }
}
