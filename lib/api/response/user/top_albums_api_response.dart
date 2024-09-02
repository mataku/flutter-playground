import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/track/track_info_api_response.dart';

part 'top_albums_api_response.freezed.dart';
part 'top_albums_api_response.g.dart';

@freezed
class TopAlbumsApiResponse with _$TopAlbumsApiResponse {
  const factory TopAlbumsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'topalbums') required AlbumRootResponse response,
  }) = _TopAlbumsApiResponse;

  factory TopAlbumsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TopAlbumsApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AlbumRootResponse {
  @JsonKey(name: 'album')
  final List<AlbumResponse> albums;

  const AlbumRootResponse({
    required this.albums,
  });

  factory AlbumRootResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumRootResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumRootResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AlbumResponse {
  final String name;
  final String playcount;
  final String mbid;
  final String url;
  final TrackInfoArtist artist;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;

  const AlbumResponse({
    required this.name,
    required this.playcount,
    required this.mbid,
    required this.url,
    required this.artist,
    required this.images,
  });

  factory AlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}
