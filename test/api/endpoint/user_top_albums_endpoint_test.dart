import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:state_app/api/endpoint/user_top_albums_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';

import '../../fixture.dart';
import '../../fixtures/test_data.dart';

void main() {
  group('UserTopAlbumsEndpoint', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late LastFmApiService apiService;

    setUp(() {
      dio = testDio;
      dioAdapter = DioAdapter(dio: dio);
      apiService = LastFmApiService(dio: dio);
    });

    test('should request with expected params', () async {
      final response = fixture('user_top_albums.json');
      dioAdapter.onGet(
        '/2.0/?method=user.gettopalbums',
        (server) => server.reply(200, jsonDecode(response)),
        data: null,
        queryParameters: {
          'format': 'json',
          'page': '1',
        },
        headers: {},
      );
      final endpoint = UserTopAlbumsEndpoint(params: {'page': '1'});
      final result = await apiService.request(endpoint);
      expect(result.response.albums.isNotEmpty, true);
    });
  });
}
