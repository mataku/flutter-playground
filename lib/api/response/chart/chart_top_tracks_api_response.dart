import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/paging_attr_body_response.dart';

part 'chart_top_tracks_api_response.freezed.dart';
part 'chart_top_tracks_api_response.g.dart';

@freezed
class ChartTopTracksApiResponse with _$ChartTopTracksApiResponse {
  const factory ChartTopTracksApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'tracks') required ChartTopTracksApiBody body,
  }) = _ChartTopTracksApiResponse;

  factory ChartTopTracksApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTracksApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChartTopTracksApiBody {
  @JsonKey(name: 'track')
  final List<ChartTrackResponse> tracks;
  @JsonKey(name: '@attr')
  final PagingAttrBodyResponse pagingAttrBodyResponse;

  const ChartTopTracksApiBody(
      {required this.tracks, required this.pagingAttrBodyResponse});

  factory ChartTopTracksApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTracksApiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChartTopTracksApiBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChartTrackResponse {
  final String name;
  @JsonKey(name: 'playcount')
  final String playCount;
  final String listeners;
  final String url;
  final ChartTrackArtistResponse artist;

  @JsonKey(name: 'image')
  final List<ImageResponse> images;

  const ChartTrackResponse({
    required this.name,
    required this.url,
    required this.playCount,
    required this.listeners,
    required this.artist,
    required this.images,
  });

  factory ChartTrackResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTrackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartTrackResponseToJson(this);
}

@freezed
class ChartTrackArtistResponse with _$ChartTrackArtistResponse {
  const factory ChartTrackArtistResponse({
    required String name,
    required String url,
  }) = _ChartTrackArtistResponse;

  factory ChartTrackArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTrackArtistResponseFromJson(json);
}
