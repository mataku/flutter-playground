import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/chart/chart_top_tracks_api_response.dart';

import '../../fixture.dart';

void main() {
  test('should parse', () async {
    final chartTopTracksJsonMap =
        json.decode(fixture('chart_top_tracks.json')) as Map<String, dynamic>;
    final result =
        ChartTopTracksApiResponse.fromJson(chartTopTracksJsonMap).body;
    final tracks = result.tracks;

    expect(tracks.isNotEmpty, true);
    final pagingAttr = result.pagingAttrBodyResponse;
    expect(pagingAttr.page, "1");
  });
}
