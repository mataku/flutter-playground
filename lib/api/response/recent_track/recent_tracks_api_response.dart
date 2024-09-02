import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/common_text_response.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'recent_tracks_api_response.freezed.dart';
part 'recent_tracks_api_response.g.dart';

@freezed
class RecentTracksApiResponse with _$RecentTracksApiResponse {
  const factory RecentTracksApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'recenttracks') required RecentTracksResponse response,
  }) = _RecentTracksApiResponse;

  factory RecentTracksApiResponse.fromJson(Map<String, dynamic> json) =>
      _$RecentTracksApiResponseFromJson(json);

  @override
  String toString() {
    return '''{
       recenttracks: $response,
    }
  ''';
  }
}

@JsonSerializable(explicitToJson: true)
class RecentTracksResponse {
  @JsonKey(name: 'track')
  final List<RecentTrackResponse> tracks;
  const RecentTracksResponse({
    required this.tracks,
  });

  factory RecentTracksResponse.fromJson(Map<String, dynamic> json) =>
      _$RecentTracksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecentTracksResponseToJson(this);
}

@freezed
class RecentTrackResponse with _$RecentTrackResponse {
  const factory RecentTrackResponse({
    required CommonTextResponse artist,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'image') required List<ImageResponse> images,
    required CommonTextResponse album,
    required String name,
    required String url,
  }) = _RecentTrackResponse;

  factory RecentTrackResponse.fromJson(Map<String, dynamic> json) =>
      _$RecentTrackResponseFromJson(json);
}

@freezed
class RecentTrackArtist with _$RecentTrackArtist {
  const factory RecentTrackArtist({
    // ignore: invalid_annotation_target
    @JsonKey(name: '#text') required String name,
  }) = _RecentTrackArtist;

  factory RecentTrackArtist.fromJson(Map<String, dynamic> json) =>
      _$RecentTrackArtistFromJson(json);
}
