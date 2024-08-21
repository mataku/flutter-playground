import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/track_repository.dart';

// avoid conflict with original MockDioException implementation in dio package
import '../fixtures/test_data.dart';
import 'recent_tracks_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException])
void main() {
  group('getTrack', () {
    late app_mock.MockLastFmApiService apiService;
    late app_mock.MockDioException dioException;

    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
    });

    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testTrackApiResponse);

      final repo = TrackRepositoryImpl(lastFmApiService: apiService);
      final result = await repo.getTrack('Supernova', 'aespa');
      expect(result is Success, true);
      expect(result.getOrNull() != null, true);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);

      final repo = TrackRepositoryImpl(lastFmApiService: apiService);
      final result = await repo.getTrack('Supernova', 'aespa');
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
