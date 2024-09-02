import 'package:dio/dio.dart';
import 'package:state_app/api/endpoint/endpoint.dart';
import 'package:state_app/api/response/auth/auth_mobile_session_api_response.dart';

class AuthGetMobileSessionEndpoint
    extends Endpoint<AuthMobileSessionApiResponse> {
  AuthGetMobileSessionEndpoint({
    super.path = '/2.0/?method=auth.getMobileSession',
    required super.params,
    super.requestType = RequestType.post,
  });

  @override
  AuthMobileSessionApiResponse parseFromJson(Response response) {
    return AuthMobileSessionApiResponse.fromJson(response.data);
  }
}
