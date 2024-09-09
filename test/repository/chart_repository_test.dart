import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_artists_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_tags_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_tracks_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/chart_repository.dart';

// avoid conflict with original MockDioException implementation in dio package
import '../fixtures/test_data.dart';
import 'chart_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late ProviderContainer providerContainer;
  group('getChartTracks', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
        ],
      );
    });

    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testChartTrackApiResponse);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartTracks(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);

      verify(apiService.request(ChartTopTracksEndpoint(
        params: {
          'page': '1',
          'limit': '10',
        },
      ))).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartTracks(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });

  group('getChartArtists', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
        ],
      );
    });

    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testChartArtistApiResponse);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartArtists(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);

      verify(apiService.request(ChartTopArtistsEndpoint(
        params: {
          'page': '1',
          'limit': '10',
        },
      ))).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartArtists(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });

  group('getChartTags', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
        ],
      );
    });

    test('request succeeded', () async {
      when(apiService.request(any))
          .thenAnswer((_) async => testChartTagApiResponse);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartTags(1);
      expect(result is Success, true);
      expect(result.getOrNull()!.isNotEmpty, true);

      verify(apiService.request(ChartTopTagsEndpoint(
        params: {
          'page': '1',
          'limit': '10',
        },
      ))).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = providerContainer.read(chartRepositoryProvider);
      final result = await repo.getChartTags(1);
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
