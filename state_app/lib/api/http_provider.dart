import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _options = BaseOptions(
  baseUrl: "https://ws.audioscrobbler.com",
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 3),
);

final dioProvider = Provider((ref) => {Dio(_options)});
