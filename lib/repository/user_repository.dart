import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/user_top_albums_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/user_top_artists_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';
import 'package:sunrisescrob/api/response/user/top_artists_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/model/user/top_artist.dart';

final userRepositoryProvider = Provider<UserRepository>(
    (ref) => UserRepositoryImpl(ref.read(lastFmApiServiceProvider)));

abstract class UserRepository {
  Future<Result<List<TopAlbum>>> getTopAlbums(int page);
  Future<Result<List<TopAlbum>>> getTopAlbumsSample(int page);
  Future<Result<List<TopArtist>>> getTopArtists(int page);
  Future<Result<List<TopArtist>>> getTopArtistsSample(int page);
}

class UserRepositoryImpl implements UserRepository {
  final LastFmApiService _lastFmApiService;

  const UserRepositoryImpl(this._lastFmApiService);

  @override
  Future<Result<List<TopAlbum>>> getTopAlbums(int page) async {
    // TODO: Set login username: `'user': 'matakucom'`
    final endpoint = UserTopAlbumsEndpoint(
      params: {'page': page.toString()},
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTopAlbumList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<TopAlbum>>> getTopAlbumsSample(int page) async {
    if (page >= 3) {
      return Result.success(List.empty());
    }
    final data = await rootBundle.loadString("asset/json/user_top_albums.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final albums = TopAlbumsApiResponse.fromJson(result);
    return Result.success(albums.toTopAlbumList());
  }

  @override
  Future<Result<List<TopArtist>>> getTopArtists(int page) async {
    // TODO: Set login username: `'user': 'matakucom'`
    final endpoint = UserTopArtistsEndpoint(
      params: {'page': page.toString()},
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTopArtistList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<TopArtist>>> getTopArtistsSample(int page) async {
    if (page >= 3) {
      return Result.success(List.empty());
    }
    final data =
        await rootBundle.loadString("asset/json/user_top_artists.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final albums = TopArtistsApiResponse.fromJson(result);
    return Result.success(albums.toTopArtistList());
  }
}
