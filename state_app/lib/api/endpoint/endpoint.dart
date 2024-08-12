import 'package:dio/dio.dart';

abstract class Endpoint<T> {
  final String path;
  final Map<String, String> params;
  final RequestType requestType;

  Endpoint(
      {required this.path, required this.params, required this.requestType});

  T parseFromJson(Response<dynamic> response);
}

enum RequestType { get, post }
