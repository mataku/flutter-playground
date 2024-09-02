# Last.fm client

Flutter Architecture Sample like Model-View-ViewModel using Last.fm API.

## Architecture

TODO

- View (Flutter Widget)
- Presentation layer: ChangeNotifier
- Data layer: Repository (or use UseCase if there are complex business logic, various data type, or something) and class with freezed and json_serializabl
- Domain layer: Dart Class with freezed:  [./lib/model/](./lib/model)

### HTTP request

uses Endpoint data class.

```dart
abstract class Endpoint<T> {
  final String path;
  final Map<String, String> params;
  final RequestType requestType;

  Endpoint({
    required this.path,
    required this.params,
    required this.requestType,
  });

  T parseFromJson(Response<dynamic> response);
}
```

```dart
// api client
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/http_provider.dart';

class LastFmApiService {
  final Dio dio;

  LastFmApiService({required this.dio});

  Future<T> request<T>(Endpoint<T> endpoint) async {
    final result = switch (endpoint.requestType) {
      RequestType.get => _get(endpoint),
      RequestType.post => _post(endpoint)
    };

    return result;
  }

  Future<T> _get<T>(Endpoint<T> endpoint) async {
    final response =
        await dio.get(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }
}
```

Define the type returned for each endpoint. In the API Client, use the `request` method with defined type in endpoint: `Future<T> request<T>(Endpoint<T> endpoint)`

```dart
// GET
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

// usage
final recentEndpoint = RecentTrackEndpoint(params: {'username': 'mataku'});
final response = await lastFmApiService.request(recentEndpoint); // RecentTracksApiResponse type
```

# Licenses

See [LICENSE](./LICENSE).

This app uses [Noto Sans Japanese](https://fonts.google.com/noto/specimen/Noto+Sans+JP).
