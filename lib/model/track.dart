import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/common_name_and_url.dart';
import 'package:state_app/model/tag.dart';
import 'package:state_app/model/wiki.dart';

part 'track.freezed.dart';

@freezed
class Track with _$Track {
  const factory Track({
    required String name,
    required String mbid,
    required String url,
    required String duration,
    required String listeners,
    required String playcount,
    required TrackAlbum album,
    required CommonNameAndUrl artist,
    required List<Tag> tags,
    required Wiki wiki,
  }) = _Track;
}

@freezed
class TrackAlbum with _$TrackAlbum {
  const factory TrackAlbum({
    required String artist,
    required String title,
    required String mbid,
    required String url,
    required List<Artwork> images,
  }) = _TrackAlbum;
}
