import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunrisescrob/api/response/artist/artist_info_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('artist_get_info.json')) as Map<String, dynamic>;
    final result = ArtistInfoApiResponse.fromJson(jsonMap);
    final response = result.body;
    expect(response.name, 'aespa');
    expect(response.images.isNotEmpty, true);
    expect(response.similarArtists?.artists.isNotEmpty, true);
    expect(response.tags.tagsResponse.isNotEmpty, true);
  });
}
