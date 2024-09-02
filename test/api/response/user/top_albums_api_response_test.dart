import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';

import '../../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('user_top_albums.json')) as Map<String, dynamic>;
    final result = TopAlbumsApiResponse.fromJson(jsonMap);
    expect(result.response.albums.isNotEmpty, true);
  });
}
