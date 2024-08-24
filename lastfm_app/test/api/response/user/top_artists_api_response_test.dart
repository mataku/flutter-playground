import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/user/top_artists_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('user_top_artists.json')) as Map<String, dynamic>;
    final result = TopArtistsApiResponse.fromJson(jsonMap);
    expect(result.response.artists.isNotEmpty, true);
  });
}
