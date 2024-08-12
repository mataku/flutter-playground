import 'package:state_app/model/common_name.dart';
import 'package:state_app/model/artwork.dart';

class RecentTrack {
  final CommonName artist;
  final CommonName album;
  final List<Artwork> images;
  final String name;
  final String url;

  RecentTrack({
    required this.artist,
    required this.album,
    required this.images,
    required this.name,
    required this.url,
  });
}
