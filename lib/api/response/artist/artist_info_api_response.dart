import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';
import 'package:sunrisescrob/api/response/similar_content_response.dart';
import 'package:sunrisescrob/api/response/top_tags_response.dart';
import 'package:sunrisescrob/api/response/wiki_response.dart';

part 'artist_info_api_response.freezed.dart';
part 'artist_info_api_response.g.dart';

@freezed
class ArtistInfoApiResponse with _$ArtistInfoApiResponse {
  const factory ArtistInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artist') required ArtistInfoBody body,
  }) = _ArtistInfoApiResponse;

  factory ArtistInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ArtistInfoApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ArtistInfoBody {
  final String name;
  final String url;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;
  final StatsBody stats;
  @JsonKey(name: 'similar')
  SimilarArtistsBody? similarArtists;
  final TopTagsResponse tags;
  @JsonKey(name: 'bio')
  WikiResponse? wiki;

  ArtistInfoBody({
    required this.name,
    required this.url,
    required this.images,
    required this.stats,
    this.similarArtists,
    required this.tags,
    this.wiki,
  });

  factory ArtistInfoBody.fromJson(Map<String, dynamic> json) =>
      _$ArtistInfoBodyFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SimilarArtistsBody {
  @JsonKey(name: 'artist')
  final List<SimilarContentResponse> artists;

  SimilarArtistsBody({
    required this.artists,
  });

  factory SimilarArtistsBody.fromJson(Map<String, dynamic> json) =>
      _$SimilarArtistsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarArtistsBodyToJson(this);
}

@freezed
class StatsBody with _$StatsBody {
  const factory StatsBody({
    required String listeners,
    required String playcount,
    String? userplaycount,
  }) = _StatsBody;

  factory StatsBody.fromJson(Map<String, dynamic> json) =>
      _$StatsBodyFromJson(json);
}
