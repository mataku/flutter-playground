import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sunrisescrob/api/response/image_response.dart';

part 'similar_content_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SimilarContentResponse {
  final String name;
  final String url;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;

  SimilarContentResponse(
      {required this.name, required this.url, required this.images});

  factory SimilarContentResponse.fromJson(Map<String, dynamic> json) =>
      _$SimilarContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SimilarContentResponseToJson(this);
}
