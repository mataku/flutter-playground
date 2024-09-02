import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/user/top_albums_api_response.dart';
import 'package:state_app/api/response/user/top_artists_api_response.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/user_repository.dart';

import '../fixture.dart';
import 'chart_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  group('getTopAlbums', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
    });

    test('request succeeded', () async {
      final response = fixture("user_top_albums.json");
      final albums = TopAlbumsApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => albums);
      final repo = UserRepositoryImpl(apiService);
      final result = await repo.getTopAlbums(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = UserRepositoryImpl(apiService);
      final result = await repo.getTopAlbums(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });

  group('getTopArtists', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
    });

    test('request succeeded', () async {
      final response = fixture("user_top_artists.json");
      final albums = TopArtistsApiResponse.fromJson(json.decode(response));
      when(apiService.request(any)).thenAnswer((_) async => albums);
      final repo = UserRepositoryImpl(apiService);
      final result = await repo.getTopArtists(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = UserRepositoryImpl(apiService);
      final result = await repo.getTopArtists(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
