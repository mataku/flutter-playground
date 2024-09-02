import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/user_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/profile/user_get_info_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/profile/user_info.dart';
import 'package:sunrisescrob/model/result.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
    (ref) => ProfileRepositoryImpl(ref.read(lastFmApiServiceProvider)));

abstract class ProfileRepository {
  Future<Result<UserInfo>> getUserInfo();
  Future<Result<UserInfo>> getUserInfoSample();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final LastFmApiService _apiService;

  ProfileRepositoryImpl(this._apiService);

  @override
  Future<Result<UserInfo>> getUserInfo() async {
    // TODO: Fetch username from local
    final endpoint = UserGetInfoEndpoint(
      params: {'user': 'matakucom'},
    );
    try {
      final response = await _apiService.request(endpoint);
      return Result.success(response.response.toUserInfo());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<UserInfo>> getUserInfoSample() async {
    final data = await rootBundle.loadString('asset/json/user_get_info.json');
    final jsonMap = json.decode(data) as Map<String, dynamic>;
    final response = UserGetInfoApiResponse.fromJson(jsonMap);
    return Result.success(response.response.toUserInfo());
  }
}
