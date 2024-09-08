import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';

part 'album_info_api_response.freezed.dart';
part 'album_info_api_response.g.dart';

@freezed
class AlbumInfoApiResponse with _$AlbumInfoApiResponse {
  const factory AlbumInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'album') required AlbumInfoApiBody response,
  }) = _AlbumInfoApiResponse;

  factory AlbumInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumInfoApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class AlbumInfoApiBody {
  final String artist;
  TopTagsResponse? tags;
  final String name;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;
  final AlbumTrackListApiBody tracks;
  final String listeners;
  final String playcount;
  int? userplaycount;
  final String url;
  WikiResponse? wikiResponse;

  AlbumInfoApiBody({
    required this.artist,
    this.tags,
    required this.name,
    required this.images,
    required this.tracks,
    required this.listeners,
    required this.playcount,
    this.userplaycount,
    required this.url,
    this.wikiResponse,
  });

  factory AlbumInfoApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumInfoApiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumInfoApiBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AlbumTrackListApiBody {
  @JsonKey(name: 'track')
  final List<AlbumTrackApiBody> tracks;

  const AlbumTrackListApiBody({
    required this.tracks,
  });

  factory AlbumTrackListApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumTrackListApiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumTrackListApiBodyToJson(this);
}

@freezed
class AlbumTrackApiBody with _$AlbumTrackApiBody {
  const factory AlbumTrackApiBody({
    int? duration,
    required String url,
    required String name,
    required TrackInfoArtist artist,
    // ignore: invalid_annotation_target
    @JsonKey(name: '@attr') required RankApiBody rankBody,
  }) = _AlbumTrackApiBody;

  factory AlbumTrackApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumTrackApiBodyFromJson(json);
}

@freezed
class RankApiBody with _$RankApiBody {
  const factory RankApiBody({
    required int rank,
  }) = _RankApiBody;

  factory RankApiBody.fromJson(Map<String, dynamic> json) =>
      _$RankApiBodyFromJson(json);
}
