import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/api/endpoint/endpoint.dart';
import 'package:state_app/api/http_provider.dart';

final lastFmApiServiceProvider =
    Provider((ref) => LastFmApiService(dio: ref.read(dioProvider)));

class LastFmApiService {
  final Dio dio;

  LastFmApiService({required this.dio});

  Future<T> request<T>(Endpoint<T> endpoint) async {
    final result = switch (endpoint.requestType) {
      RequestType.get => _get(endpoint),
      RequestType.post => throw Exception("TODO!")
    };

    return result;
  }

  Future<T> _get<T>(Endpoint<T> endpoint) async {
    final response =
        await dio.get(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }
}
