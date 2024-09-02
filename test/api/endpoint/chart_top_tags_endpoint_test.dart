import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_tags_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';

import '../../fixture.dart';
import '../../fixtures/test_data.dart';

void main() {
  group('ChartTopTagsEndpoint', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late LastFmApiService apiService;
    setUp(() {
      dio = testDio;
      dioAdapter = DioAdapter(dio: dio);
      apiService = LastFmApiService(dio: dio);
    });

    test('should request with expected params', () async {
      final response = fixture('chart_top_tags.json');
      dioAdapter.onGet('/2.0/?method=chart.gettoptags',
          (server) => server.reply(200, jsonDecode(response)),
          data: null, queryParameters: {'format': 'json'}, headers: {});
      apiService = LastFmApiService(dio: dio);
      final endpoint = ChartTopTagsEndpoint(params: {});
      final result = await apiService.request(endpoint);
      expect(result.body.tags.isNotEmpty, true);
    });
  });
}
