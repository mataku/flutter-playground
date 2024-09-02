import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/http_provider.dart';

final lastFmApiServiceProvider =
    Provider((ref) => LastFmApiService(dio: ref.read(dioProvider)));

class LastFmApiService {
  final Dio _dio;

  LastFmApiService({required Dio dio}) : _dio = dio;

  Future<T> request<T>(Endpoint<T> endpoint) async {
    final result = switch (endpoint.requestType) {
      RequestType.get => _get(endpoint),
      RequestType.post => _post(endpoint),
    };

    return result;
  }

  Future<T> _get<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.get(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }

  Future<T> _post<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.post(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }
}
