import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/album_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/album/album_info_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/album_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';

import '../fixture.dart';
import 'album_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, KVStore, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late app_mock.MockKVStore kvStore;

  group('getAlbumInfo', () {
    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      kvStore = app_mock.MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.username)).thenAnswer((_) async {
        return 'sunsetscrob';
      });
    });

    test('request succeeded', () async {
      final response = fixture('album_get_info.json');
      final album = AlbumInfoApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => album);
      final repo =
          AlbumRepositoryImpl(apiService: apiService, kvStore: kvStore);
      final result = await repo.getAlbumInfo(artist: 'aespa', album: 'Drama');
      expect(result is Success, true);
      expect(result.getOrNull()!.artist, 'aespa');
      verify(apiService.request(
        argThat(
          equals(
            AlbumGetInfoEndpoint(
              params: {
                'album': 'Drama',
                'artist': 'aespa',
                'user': 'sunsetscrob',
              },
            ),
          ),
        ),
      )).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(
        apiService.request(
          AlbumGetInfoEndpoint(
            params: {
              'artist': 'aespa',
              'album': 'Drama',
              'user': 'sunsetscrob',
            },
          ),
        ),
      ).thenThrow(dioException);
      final repo =
          AlbumRepositoryImpl(apiService: apiService, kvStore: kvStore);
      final result = await repo.getAlbumInfo(artist: 'aespa', album: 'Drama');
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
