import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/ui/home/component/top_album_component.dart';

class TopAlbumsComponent extends StatelessWidget {
  final List<TopAlbum> albums;
  final bool hasMore;
  final ScrollController scrollController;

  const TopAlbumsComponent({
    super.key,
    required this.albums,
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
          childAspectRatio: 0.72,
        ),
        itemCount: albums.length,
        itemBuilder: (BuildContext context, int index) {
          final album = albums[index];
          return TopAlbumComponent(
            imageUrl: album.images.imageUrl() ?? '',
            album: album.name,
            artist: album.artist.name,
            playcount: album.playcount,
          );
        },
        controller: scrollController,
      ),
    );

    // CustomScrollView(
    //   controller: scrollController,
    //   slivers: [
    //     SliverGrid.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 8,
    //       crossAxisSpacing: 8,
    //       childAspectRatio: 0.75,
    //       children: albums
    //           .map(
    //             (album) => TopAlbumComponent(
    //               imageUrl: album.images.imageUrl() ?? '',
    //               album: album.name,
    //               artist: album.artist.name,
    //               playcount: album.playcount,
    //             ),
    //           )
    //           .toList(),
    //     ),
    //     if (albums.isNotEmpty && hasMore)
    //       const SliverFillRemaining(
    //         hasScrollBody: false,
    //         child: Padding(
    //           padding: EdgeInsets.only(top: 16, bottom: 16),
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       ),
    //   ],
    // ),
  }
}
