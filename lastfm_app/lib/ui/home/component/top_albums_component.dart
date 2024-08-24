import 'package:flutter/material.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/ui/home/component/top_album_component.dart';

class TopAlbumsComponent extends StatelessWidget {
  final List<TopAlbum> albums;

  const TopAlbumsComponent({
    super.key,
    required this.albums,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CustomScrollView(
        slivers: [
          SliverGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.75,
            children: albums
                .map(
                  (album) => TopAlbumComponent(
                    imageUrl: album.images.imageUrl() ?? '',
                    album: album.name,
                    artist: album.artist.name,
                    playcount: album.playcount,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
