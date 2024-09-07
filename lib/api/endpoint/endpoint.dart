import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class Endpoint<T> {
  final String path;
  final Map<String, String> params;
  final RequestType requestType;

  Endpoint(
      {required this.path, required this.params, required this.requestType});

  T parseFromJson(Response<dynamic> response);

  @override
  bool operator ==(dynamic other) {
    return other is Endpoint &&
        other.path == path &&
        mapEquals(other.params, params) &&
        other.requestType == requestType;
  }

  @override
  int get hashCode {
    return Object.hash(
      path.hashCode,
      params.hashCode,
      requestType.hashCode,
    );
  }
}

enum RequestType { get, post }
