import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/track/track_info_api_response.dart';

import '../../fixture.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('track_get_info.json')) as Map<String, dynamic>;
    final result = TrackInfoApiResponse.fromJson(jsonMap);
    final response = result.response;
    expect(response.artist.name, 'Coldplay');
    expect(response.name, 'Clocks');
    expect(response.album.images.isNotEmpty, true);
    expect(response.tags.tagsResponse.isNotEmpty, true);
  });
}
