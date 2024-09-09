import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/endpoint/auth_get_mobile_session_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/lastfm_api_signature.dart';
import 'package:sunrisescrob/api/response/auth/auth_mobile_session_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/auth_repository.dart';
import 'package:sunrisescrob/store/session_store.dart';

import '../fixture.dart';
import 'auth_repository_test.mocks.dart' as app_mock;

@GenerateMocks([LastFmApiService, SessionChangeNotifier, DioException])
void main() {
  late app_mock.MockLastFmApiService apiService;
  late app_mock.MockDioException dioException;
  late app_mock.MockSessionChangeNotifier sessionChangeNotifier;
  late ProviderContainer providerContainer;

  group('authorize', () {
    const username = 'mataku';
    const password = 'password1';

    setUp(() async {
      apiService = app_mock.MockLastFmApiService();
      dioException = app_mock.MockDioException();
      sessionChangeNotifier = app_mock.MockSessionChangeNotifier();
      providerContainer = ProviderContainer(
        overrides: [
          lastFmApiServiceProvider.overrideWithValue(apiService),
          sessionChangeNotifierProvider
              .overrideWith((ref) => sessionChangeNotifier),
        ],
      );
    });

    test('request succeeded', () async {
      final rawResponse = fixture('mobile_session.json');
      final mobileSession =
          AuthMobileSessionApiResponse.fromJson(json.decode(rawResponse));
      when(apiService.request(any)).thenAnswer((_) async => mobileSession);
      final repo = providerContainer.read(authRepositoryProvider);
      final result = await repo.authorize(
        username: username,
        password: password,
      );
      expect(result is Success, true);
      var params = {
        'username': username,
        'password': password,
        'method': 'auth.getMobileSession',
      };
      final apiSignature = LastfmApiSignature.generate(params);
      params['api_sig'] = apiSignature;

      verify(apiService.request(AuthGetMobileSessionEndpoint(
        params: params,
      ))).called(1);

      verify(sessionChangeNotifier.login(
        sessionKey: mobileSession.sessionBody.key,
        username: mobileSession.sessionBody.name,
      )).called(1);
    });

    test('request failed', () async {
      when(dioException.type).thenReturn(DioExceptionType.connectionError);
      when(
        apiService.request(any),
      ).thenThrow(dioException);

      final repo = providerContainer.read(authRepositoryProvider);
      final result = await repo.authorize(
        username: username,
        password: password,
      );
      expect(result is Failure, true);
      expect(result.exceptionOrNull(), const AppError.serverError());
    });
  });
}
