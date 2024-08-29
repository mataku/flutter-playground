import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/api/endpoint/auth_get_mobile_session_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/lastfm_api_signature.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';

final authRepositoryProvider =
    Provider((ref) => AuthRepositoryImpl(ref.read(lastFmApiServiceProvider)));

abstract class AuthRepository {
  Future<Result<String>> authorize({
    required String username,
    required String password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final LastFmApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Future<Result<String>> authorize(
      {required String username, required String password}) async {
    Map<String, String> params = {
      'username': username,
      'password': password,
      'method': 'auth.getMobileSession',
    };
    final apiSignature = LastfmApiSignature.generate(params);
    params['api_sig'] = apiSignature;

    final endpoint = AuthGetMobileSessionEndpoint(
      params: params,
    );
    try {
      final result = await _apiService.request(endpoint);
      return Result.success(result.sessionBody.name);
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
