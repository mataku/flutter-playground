import 'package:dio/dio.dart';
import 'package:state_app/api/endpoint/endpoint.dart';
import 'package:state_app/api/response/chart/chart_top_artists_api_response.dart';

class ChartTopArtistsEndpoint extends Endpoint<ChartTopArtistsApiResponse> {
  ChartTopArtistsEndpoint({
    super.path = '/2.0/?method=chart.gettopartists',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  ChartTopArtistsApiResponse parseFromJson(Response response) {
    return ChartTopArtistsApiResponse.fromJson(response.data);
  }
}
