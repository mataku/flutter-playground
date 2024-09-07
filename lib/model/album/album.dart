import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/model/artwork.dart';
import 'package:sunrisescrob/model/common_name_and_url.dart';
import 'package:sunrisescrob/model/tag.dart';

part 'album.freezed.dart';

@freezed
class Album with _$Album {
  const factory Album({
    required String artist,
    required String name,
    required List<Tag> tags,
    required List<Artwork> images,
    required List<AlbumTrack> tracks,
    required String listeners,
    required String playcount,
    required String userplaycount,
    required String url,
  }) = _Album;
}

@freezed
class AlbumTrack with _$AlbumTrack {
  const factory AlbumTrack({
    required int duration,
    required String url,
    required String name,
    required int position,
    required CommonNameAndUrl artist,
  }) = _AlbumTrack;
}
