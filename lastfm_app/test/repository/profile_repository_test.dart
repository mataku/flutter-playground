import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/profile/user_get_info_api_response.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/profile_repository.dart';

import '../fixture.dart';
import 'chart_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;

  group('getUserInfo', () {
    setUp(() {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
    });

    test('request succeeded', () async {
      final jsonMap = fixture('user_get_info.json');
      final userInfo = UserGetInfoApiResponse.fromJson(json.decode(jsonMap));
      when(apiService.request(any)).thenAnswer((_) async => userInfo);
      final repo = ProfileRepositoryImpl(apiService: apiService);
      final result = await repo.getUserInfo();
      expect(result is Success, true);
      expect(result.getOrNull()!.name, 'matakucom');
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(apiService.request(any)).thenThrow(dioException);
      final repo = ProfileRepositoryImpl(apiService: apiService);
      final result = await repo.getUserInfo();
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
