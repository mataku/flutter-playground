import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunrisescrob/api/response/album/album_info_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('album_get_info.json')) as Map<String, dynamic>;
    final result = AlbumInfoApiResponse.fromJson(jsonMap);
    final response = result.response;
    expect(response.artist, 'aespa');
    expect(response.tags?.tagsResponse.isNotEmpty, true);
    expect(response.name, 'Drama');
    expect(response.images.isNotEmpty, true);
    expect(response.tracks.tracks.isNotEmpty, true);
  });
}
