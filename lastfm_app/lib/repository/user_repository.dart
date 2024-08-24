import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/api/endpoint/user_top_albums_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/user/top_albums_api_response.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/user/top_album.dart';

final userRepositoryProvider = Provider((ref) =>
    UserRepositoryImpl(lastFmApiService: ref.read(lastFmApiServiceProvider)));

abstract class UserRepository {
  Future<Result<List<TopAlbum>>> getTopAlbums(int page);
  Future<Result<List<TopAlbum>>> getTopAlbumsSample(int page);
}

class UserRepositoryImpl implements UserRepository {
  final LastFmApiService lastFmApiService;

  const UserRepositoryImpl({required this.lastFmApiService});

  @override
  Future<Result<List<TopAlbum>>> getTopAlbums(int page) async {
    final endpoint = UserTopAlbumsEndpoint(
      params: {'page': page.toString()},
    );
    try {
      final response = await lastFmApiService.request(endpoint);
      return Result.success(response.toTopAlbumList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<TopAlbum>>> getTopAlbumsSample(int page) async {
    final data = await rootBundle.loadString("asset/json/user_top_albums.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final albums = TopAlbumsApiResponse.fromJson(result);
    debugPrint("MATAKUDEBUG $albums");
    return Result.success(albums.toTopAlbumList());
  }
}
