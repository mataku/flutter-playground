import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'common_text_response.freezed.dart';
part 'common_text_response.g.dart';

@freezed
class CommonTextResponse with _$CommonTextResponse {
  @JsonSerializable(explicitToJson: true)
  factory CommonTextResponse({
    @JsonKey(name: '#text') required String name,
  }) = _CommonTextResponse;

  factory CommonTextResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonTextResponseFromJson(json);
}
