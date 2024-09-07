import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/recent_tracks_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/store/kv_store.dart';

abstract class RecentTracksRepository {
  Future<Result<List<RecentTrack>>> getRecentTracks(int page);
}

final recentTracksRepositoryProvider = Provider<RecentTracksRepository>(
  (ref) => RecentTracksRepositoryImpl(
    apiService: ref.read(lastFmApiServiceProvider),
    kvStore: ref.read(kvStoreProvider),
  ),
);

class RecentTracksRepositoryImpl implements RecentTracksRepository {
  final LastFmApiService _lastFmApiService;
  final KVStore _kvStore;

  RecentTracksRepositoryImpl({
    required LastFmApiService apiService,
    required KVStore kvStore,
  })  : _lastFmApiService = apiService,
        _kvStore = kvStore;

  @override
  Future<Result<List<RecentTrack>>> getRecentTracks(int page) async {
    final username = await _kvStore.getStringValue(KVStoreKey.username);
    final endpoint = RecentTracksEndpoint(
      params: {
        'page': page.toString(),
        'user': username,
      },
    );
    try {
      final result = await _lastFmApiService.request(endpoint);
      return Result.success(result.toRecentTrackList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
