import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';

import '../../fixture.dart';

void main() {
  test('should parse', () async {
    final recentTracksJsonMap =
        json.decode(fixture('recent_tracks.json')) as Map<String, dynamic>;
    final result = RecentTracksApiResponse.fromJson(recentTracksJsonMap);
    final tracks = result.response.tracks;
    expect(tracks.isNotEmpty, true);
  });
}
