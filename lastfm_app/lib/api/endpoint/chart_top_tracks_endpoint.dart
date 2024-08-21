import 'package:dio/dio.dart';
import 'package:state_app/api/endpoint/endpoint.dart';
import 'package:state_app/api/response/chart_top_tracks_api_response.dart';

class ChartTopTracksEndpoint extends Endpoint<ChartTopTracksApiResponse> {
  ChartTopTracksEndpoint({
    super.path = '/2.0/?method=chart.gettoptracks',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  ChartTopTracksApiResponse parseFromJson(Response response) {
    return ChartTopTracksApiResponse.fromJson(response.data);
  }
}
