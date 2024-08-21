import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/chart_top_artists_api_response.dart';

import '../../fixture.dart';

void main() {
  test('should parse', () async {
    final chartTopArtistsJsonMap =
        json.decode(fixture('chart_top_artists.json')) as Map<String, dynamic>;
    final result =
        ChartTopArtistsApiResponse.fromJson(chartTopArtistsJsonMap).body;
    final artists = result.artists;

    expect(artists.isNotEmpty, true);
    final pagingAttr = result.pagingAttrBodyResponse;
    expect(pagingAttr.page, "1");
  });
}
