import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/profile/user_get_info_api_response.dart';

class UserGetInfoEndpoint extends Endpoint<UserGetInfoApiResponse> {
  UserGetInfoEndpoint({
    super.path = '/2.0/?method=user.getinfo',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  UserGetInfoApiResponse parseFromJson(Response response) {
    return UserGetInfoApiResponse.fromJson(response.data);
  }
}
