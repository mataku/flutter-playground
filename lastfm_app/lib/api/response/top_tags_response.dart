import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_tags_response.freezed.dart';
part 'top_tags_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TopTagsResponse {
  @JsonKey(name: 'tag')
  final List<TagResponse> tagsResponse;

  const TopTagsResponse({
    required this.tagsResponse,
  });

  factory TopTagsResponse.fromJson(Map<String, dynamic> json) =>
      _$TopTagsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopTagsResponseToJson(this);
}

@freezed
class TagResponse with _$TagResponse {
  const factory TagResponse({
    required String name,
    required String url,
  }) = _TagResponse;

  factory TagResponse.fromJson(Map<String, dynamic> json) =>
      _$TagResponseFromJson(json);
}
