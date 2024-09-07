import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/album/album_info_api_response.dart';

class AlbumGetInfoEndpoint extends Endpoint<AlbumInfoApiResponse> {
  AlbumGetInfoEndpoint({
    super.path = '/2.0/?method=album.getInfo',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  AlbumInfoApiResponse parseFromJson(Response response) {
    return AlbumInfoApiResponse.fromJson(response.data);
  }
}
