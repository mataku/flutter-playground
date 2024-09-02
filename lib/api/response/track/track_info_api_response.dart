import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';

part 'track_info_api_response.freezed.dart';
part 'track_info_api_response.g.dart';

@freezed
class TrackInfoApiResponse with _$TrackInfoApiResponse {
  const factory TrackInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'track') required TrackInfoResponse response,
  }) = _TrackInfoApiResponse;

  factory TrackInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoApiResponseFromJson(json);
}

@freezed
class TrackInfoResponse with _$TrackInfoResponse {
  const factory TrackInfoResponse({
    required String name,
    required String mbid,
    required String url,
    required String duration,
    required String listeners,
    required String playcount,
    required TrackInfoArtist artist,
    required TrackAlbumResponse album,
    required WikiResponse wiki,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'toptags') required TopTagsResponse tags,
  }) = _TrackInfoResponse;

  factory TrackInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TrackAlbumResponse {
  final String artist;
  final String title;
  final String mbid;
  final String url;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;
  const TrackAlbumResponse({
    required this.artist,
    required this.title,
    required this.mbid,
    required this.url,
    // ignore: invalid_annotation_target
    required this.images,
  });

  factory TrackAlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackAlbumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackAlbumResponseToJson(this);
}

@freezed
class WikiResponse with _$WikiResponse {
  const factory WikiResponse({
    required String published,
    required String summary,
    required String content,
  }) = _WikiResponse;

  factory WikiResponse.fromJson(Map<String, dynamic> json) =>
      _$WikiResponseFromJson(json);
}

@freezed
class TrackInfoArtist with _$TrackInfoArtist {
  const factory TrackInfoArtist({
    required String name,
    required String mbid,
    required String url,
  }) = _TrackInfoArtist;

  factory TrackInfoArtist.fromJson(Map<String, dynamic> json) =>
      _$TrackInfoArtistFromJson(json);
}
