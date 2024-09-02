import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';

class UserTopAlbumsEndpoint extends Endpoint<TopAlbumsApiResponse> {
  UserTopAlbumsEndpoint({
    super.path = '/2.0/?method=user.gettopalbums',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  TopAlbumsApiResponse parseFromJson(Response response) {
    return TopAlbumsApiResponse.fromJson(response.data);
  }
}
