import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_app/api/response/image_response.dart';

part 'user_get_info_api_response.freezed.dart';
part 'user_get_info_api_response.g.dart';

@freezed
class UserGetInfoApiResponse with _$UserGetInfoApiResponse {
  const factory UserGetInfoApiResponse({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'user') required UserGetInfoResponse response,
  }) = _UserGetInfoApiResponse;

  factory UserGetInfoApiResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGetInfoApiResponseFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UserGetInfoResponse {
  final String name;
  final String subscriber;
  final String playcount;
  @JsonKey(name: 'artist_count')
  final String artistCount;
  @JsonKey(name: 'track_count')
  final String trackCount;
  @JsonKey(name: 'album_count')
  final String albumCount;
  @JsonKey(name: 'image')
  final List<ImageResponse> images;
  final String url;

  const UserGetInfoResponse({
    required this.name,
    required this.subscriber,
    required this.playcount,
    required this.artistCount,
    required this.trackCount,
    required this.albumCount,
    required this.images,
    required this.url,
  });

  factory UserGetInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGetInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserGetInfoResponseToJson(this);
}
