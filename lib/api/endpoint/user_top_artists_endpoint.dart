import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/user/top_artists_api_response.dart';

class UserTopArtistsEndpoint extends Endpoint<TopArtistsApiResponse> {
  UserTopArtistsEndpoint({
    super.path = '/2.0/?method=user.gettopartists',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  TopArtistsApiResponse parseFromJson(Response response) {
    return TopArtistsApiResponse.fromJson(response.data);
  }
}
