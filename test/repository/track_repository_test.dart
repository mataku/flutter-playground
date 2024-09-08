import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/track_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/track_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

// avoid conflict with original MockDioException implementation in dio package
import '../fixtures/test_data.dart';
import 'track_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException, KVStore])
void main() {
  group('getTrack', () {
    const username = 'sunsetscrob';
    late app_mock.MockLastFmApiService apiService;
    late app_mock.MockDioException dioException;
    late app_mock.MockKVStore kvStore;

    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return username;
      });
    });

    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testTrackApiResponse);

      final repo = TrackRepositoryImpl(
        lastFmApiService: apiService,
        kvStore: kvStore,
      );
      final result = await repo.getTrack(
        track: 'Supernova',
        artist: 'aespa',
      );
      expect(result is Success, true);
      expect(result.getOrNull() != null, true);

      verify(kvStore.getStringValue(KVStoreKey.username)).called(1);

      verify(apiService.request(TrackInfoEndpoint(
        params: {
          'artist': 'aespa',
          'track': 'Supernova',
          'username': username,
        },
      ))).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);

      final repo = TrackRepositoryImpl(
        lastFmApiService: apiService,
        kvStore: kvStore,
      );

      final result = await repo.getTrack(
        track: 'Supernova',
        artist: 'aespa',
      );
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
