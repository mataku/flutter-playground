import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/recent_tracks_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/recent_tracks_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

import '../fixtures/test_data.dart';
// avoid conflict with original MockDioException implementation in dio package
import 'recent_tracks_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException, KVStore])
void main() {
  group('getRecentTracks', () {
    late app_mock.MockLastFmApiService apiService;
    late app_mock.MockDioException dioException;
    late app_mock.MockKVStore kvStore;
    late ProviderContainer providerContainer;
    const username = 'sunsetscrob';

    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return username;
      });
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });
    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testRecentTrackApiResponse);
      final repo = providerContainer.read(recentTracksRepositoryProvider);
      final result = await repo.getRecentTracks(1);
      expect(result is Success, true);
      expect(
          result.getOrNull()!, testRecentTrackApiResponse.toRecentTrackList(),);

      verify(kvStore.getStringValue(KVStoreKey.username)).called(1);

      verify(apiService.request(RecentTracksEndpoint(
        params: {
          'page': '1',
          'user': username,
        },
      ),),).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(recentTracksRepositoryProvider);
      final result = await repo.getRecentTracks(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
