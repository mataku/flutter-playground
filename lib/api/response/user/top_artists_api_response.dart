import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'top_artists_api_response.freezed.dart';
part 'top_artists_api_response.g.dart';

@freezed
class TopArtistsApiResponse with _$TopArtistsApiResponse {
  const factory TopArtistsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'topartists') required TopArtistsResponse response,
  }) = _TopArtistsApiResponse;

  factory TopArtistsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$TopArtistsApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TopArtistsResponse {
  @JsonKey(name: 'artist')
  final List<ArtistResponse> artists;

  const TopArtistsResponse({
    required this.artists,
  });

  factory TopArtistsResponse.fromJson(Map<String, dynamic> json) =>
      _$TopArtistsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopArtistsResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ArtistResponse {
  final String name;
  final String url;
  final String playcount;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;

  const ArtistResponse({
    required this.name,
    required this.url,
    required this.playcount,
    required this.images,
  });

  factory ArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistResponseToJson(this);
}
