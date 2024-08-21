import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/api/response/image_response.dart';
import 'package:state_app/api/response/paging_attr_body_response.dart';

part 'chart_top_artists_api_response.freezed.dart';
part 'chart_top_artists_api_response.g.dart';

@freezed
class ChartTopArtistsApiResponse with _$ChartTopArtistsApiResponse {
  const factory ChartTopArtistsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'artists') required ChartTopArtistsApiBody body,
  }) = _ChartTopArtistsApiResponse;

  factory ChartTopArtistsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopArtistsApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChartTopArtistsApiBody {
  @JsonKey(name: 'artist')
  final List<ChartArtistResponse> artists;
  @JsonKey(name: '@attr')
  final PagingAttrBodyResponse pagingAttrBodyResponse;

  const ChartTopArtistsApiBody({
    required this.artists,
    required this.pagingAttrBodyResponse,
  });

  factory ChartTopArtistsApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopArtistsApiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChartTopArtistsApiBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChartArtistResponse {
  final String name;
  @JsonKey(name: 'playcount')
  final String playCount;
  final String listeners;
  final String url;

  @JsonKey(name: 'image')
  final List<ImageResponse> images;

  const ChartArtistResponse({
    required this.name,
    required this.url,
    required this.playCount,
    required this.listeners,
    required this.images,
  });

  factory ChartArtistResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartArtistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChartArtistResponseToJson(this);
}
