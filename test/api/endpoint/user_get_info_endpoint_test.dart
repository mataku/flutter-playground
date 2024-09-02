import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:sunrisescrob/api/endpoint/user_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';

import '../../fixture.dart';
import '../../fixtures/test_data.dart';

void main() {
  group('UserGetInfoEndpoint', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late LastFmApiService apiService;

    setUp(() {
      dio = testDio;
      dioAdapter = DioAdapter(dio: dio);
      apiService = LastFmApiService(dio: dio);
    });

    test('should request with expected params', () async {
      final response = fixture('user_get_info.json');
      dioAdapter.onGet(
        '/2.0/?method=user.getinfo',
        (server) => server.reply(200, jsonDecode(response)),
        data: null,
        queryParameters: {
          'format': 'json',
          'user': 'matakucom',
        },
        headers: {},
      );
      final endpoint = UserGetInfoEndpoint(
        params: {
          'user': 'matakucom',
        },
      );
      final result = await apiService.request(endpoint);
      expect(result.response.name, 'matakucom');
    });
  });
}
