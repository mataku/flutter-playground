import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/album_get_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/album/album.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  return AlbumRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  );
});

abstract class AlbumRepository {
  Future<Result<Album>> getAlbumInfo({
    required String artist,
    required String album,
  });
}

class AlbumRepositoryImpl implements AlbumRepository {
  final LastFmApiService _apiService;
  final KVStore _kvStore;

  AlbumRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _apiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<Album>> getAlbumInfo({
    required String artist,
    required String album,
  }) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = AlbumGetInfoEndpoint(
      params: {
        'album': album,
        'artist': artist,
        'user': username,
      },
    );
    debugPrint("MATAKUDEBUG $endpoint");
    try {
      final result = await _apiService.request(endpoint);
      debugPrint("MATAKUDEBUG result $result");
      return Result.success(result.toAlbum());
    } on Exception catch (error) {
      debugPrint("MATAKUDEBUG result $error");
      return Result.failure(AppError.getApiError(error));
    }
  }
}
