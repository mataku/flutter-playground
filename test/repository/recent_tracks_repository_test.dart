import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/recent_tracks_repository.dart';

import '../fixtures/test_data.dart';
// avoid conflict with original MockDioException implementation in dio package
import 'recent_tracks_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException])
void main() {
  group('getRecentTracks', () {
    late app_mock.MockLastFmApiService apiService;
    late app_mock.MockDioException dioException;

    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
    });
    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testRecentTrackApiResponse);
      final repo = RecentTracksRepositoryImpl(apiService);
      final result = await repo.getRecentTracks(1);
      expect(result is Success, true);
      expect(
          result.getOrNull()!, testRecentTrackApiResponse.toRecentTrackList());
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = RecentTracksRepositoryImpl(apiService);
      final result = await repo.getRecentTracks(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}