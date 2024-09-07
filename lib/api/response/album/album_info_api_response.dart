import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';

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
  String? userplaycount;
  final String url;

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
    required int duration,
    required String url,
    required String name,
    required TrackInfoArtist artist,
  }) = _AlbumTrackApiBody;

  factory AlbumTrackApiBody.fromJson(Map<String, dynamic> json) =>
      _$AlbumTrackApiBodyFromJson(json);
}
