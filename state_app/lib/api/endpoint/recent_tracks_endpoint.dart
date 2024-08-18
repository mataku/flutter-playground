import 'package:dio/dio.dart';
import 'package:state_app/api/endpoint/endpoint.dart';
import 'package:state_app/api/response/recent_tracks_api_response.dart';

class RecentTracksEndpoint extends Endpoint<RecentTracksApiResponse> {
  RecentTracksEndpoint(
      {super.path = '/2.0/?method=user.getrecenttracks',
      required super.params,
      super.requestType = RequestType.get});

  @override
  RecentTracksApiResponse parseFromJson(Response response) {
    return RecentTracksApiResponse.fromJson(response.data);
  }
}
