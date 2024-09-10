import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/artist_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/artist/artist_info_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/artist_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

import '../fixture.dart';
import 'artist_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, KVStore, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late app_mock.MockKVStore kvStore;
  late ProviderContainer providerContainer;

  group('getArtistInfo', () {
    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return 'sunsetscrob';
      });
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });

    test('request succeeded', () async {
      final response = fixture('artist_get_info.json');
      final album = ArtistInfoApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => album);
      final repo = providerContainer.read(artistRepositoryProvider);
      final result = await repo.getArtistInfo(artist: 'aespa');
      expect(result is Success, true);
      verify(apiService.request(
        argThat(
          equals(
            ArtistGetInfoEndpoint(
              params: {
                'artist': 'aespa',
                'user': 'sunsetscrob',
              },
            ),
          ),
        ),
      ),).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(
        apiService.request(
          ArtistGetInfoEndpoint(
            params: {
              'artist': 'aespa',
              'user': 'sunsetscrob',
            },
          ),
        ),
      ).thenThrow(dioException);
      final repo = providerContainer.read(artistRepositoryProvider);
      final result = await repo.getArtistInfo(artist: 'aespa');
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
