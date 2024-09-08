import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/artist/artist_info_api_response.dart';

class ArtistGetInfoEndpoint extends Endpoint<ArtistInfoApiResponse> {
  ArtistGetInfoEndpoint({
    super.path = '/2.0/?method=artist.getInfo',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  ArtistInfoApiResponse parseFromJson(Response response) {
    return ArtistInfoApiResponse.fromJson(response.data);
  }
}
