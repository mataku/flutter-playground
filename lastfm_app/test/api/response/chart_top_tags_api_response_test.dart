import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:state_app/api/response/chart/chart_top_tags_api_response.dart';

import '../../fixture.dart';

void main() {
  test('should parse', () async {
    final chartTopTagsJsonMap =
        json.decode(fixture('chart_top_tags.json')) as Map<String, dynamic>;
    final result = ChartTopTagsApiResponse.fromJson(chartTopTagsJsonMap).body;
    final tags = result.tags;

    expect(tags.isNotEmpty, true);
    final pagingAttr = result.pagingAttrBodyResponse;
    expect(pagingAttr.page, "1");
  });
}
