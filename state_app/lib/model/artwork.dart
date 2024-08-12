import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork.freezed.dart';

@freezed
class Artwork with _$Artwork {
  const factory Artwork({
    required String size,
    required String url,
  }) = _Artwork;
}
