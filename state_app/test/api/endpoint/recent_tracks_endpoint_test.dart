import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:state_app/api/endpoint/recent_tracks_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';

import '../../fixture.dart';

void main() {
  group('RecentTracksEndpoint', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late LastFmApiService apiService;
    setUp(() {
      final options = BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      );
      dio = Dio(options);
      dioAdapter = DioAdapter(dio: dio);
      apiService = LastFmApiService(dio: dio);
    });

    test('should request with expected params', () async {
      final response = fixture('recent_tracks.json');
      dioAdapter.onGet('/2.0/?method=user.getrecenttracks',
          (server) => server.reply(200, jsonDecode(response)),
          data: null, queryParameters: {}, headers: {});
      apiService = LastFmApiService(dio: dio);
      final endpoint = RecentTracksEndpoint(params: {});
      final result = await apiService.request(endpoint);
      expect(result.response.tracks.isNotEmpty, true);
    });
  });
}
