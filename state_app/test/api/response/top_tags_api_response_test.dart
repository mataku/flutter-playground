import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../fixture.dart';
import 'top_tags_response.dart';

void main() {
  test('should parse', () async {
    final jsonMap =
        json.decode(fixture('top_tags.json')) as Map<String, dynamic>;
    final result = TopTagsApiResponse.fromJson(jsonMap);
    final tags = result.tagsBody.tagsResponse;
    expect(tags.isNotEmpty, true);
  });
}
