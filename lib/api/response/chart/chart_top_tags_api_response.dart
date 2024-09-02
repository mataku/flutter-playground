import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/api/response/paging_attr_body_response.dart';

part 'chart_top_tags_api_response.freezed.dart';
part 'chart_top_tags_api_response.g.dart';

@freezed
class ChartTopTagsApiResponse with _$ChartTopTagsApiResponse {
  const factory ChartTopTagsApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'tags') required ChartTopTagsApiBody body,
  }) = _ChartTopTagsApiResponse;

  factory ChartTopTagsApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagsApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ChartTopTagsApiBody {
  @JsonKey(name: 'tag')
  final List<ChartTopTagResponse> tags;
  @JsonKey(name: '@attr')
  final PagingAttrBodyResponse pagingAttrBodyResponse;

  const ChartTopTagsApiBody({
    required this.tags,
    required this.pagingAttrBodyResponse,
  });

  factory ChartTopTagsApiBody.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagsApiBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChartTopTagsApiBodyToJson(this);
}

@freezed
class ChartTopTagResponse with _$ChartTopTagResponse {
  const factory ChartTopTagResponse({
    required String name,
    required String url,
  }) = _ChartTopTagResponse;

  factory ChartTopTagResponse.fromJson(Map<String, dynamic> json) =>
      _$ChartTopTagResponseFromJson(json);
}
