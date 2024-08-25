import 'package:state_app/api/endpoint/user_get_info_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/profile/user_info.dart';
import 'package:state_app/model/result.dart';

abstract class ProfileRepository {
  Future<Result<UserInfo>> getUserInfo();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final LastFmApiService apiService;

  const ProfileRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<Result<UserInfo>> getUserInfo() async {
    // Fetch username from local
    final endpoint = UserGetInfoEndpoint(
      params: {'user': 'matakucom'},
    );
    try {
      final response = await apiService.request(endpoint);
      return Result.success(response.response.toUserInfo());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
