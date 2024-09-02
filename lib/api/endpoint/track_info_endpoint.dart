import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';

class TrackInfoEndpoint extends Endpoint<TrackInfoApiResponse> {
  TrackInfoEndpoint({
    super.path = '/2.0/?method=track.getInfo',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  TrackInfoApiResponse parseFromJson(Response response) {
    return TrackInfoApiResponse.fromJson(response.data);
  }
}
