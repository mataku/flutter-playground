import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/api/endpoint/recent_tracks_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/recent_track.dart';
import 'package:state_app/model/result.dart';

abstract class RecentTracksRepository {
  Future<Result<List<RecentTrack>>> getRecentTracks(int page);
}

final recentTracksRepositoryProvider = Provider((ref) =>
    RecentTracksRepositoryImpl(
        lastFmApiService: ref.read(lastFmApiServiceProvider)));

class RecentTracksRepositoryImpl implements RecentTracksRepository {
  final LastFmApiService lastFmApiService;
  RecentTracksRepositoryImpl({required this.lastFmApiService});

  @override
  Future<Result<List<RecentTrack>>> getRecentTracks(int page) async {
    final endpoint = RecentTracksEndpoint(
        params: {'page': page.toString(), 'user': 'matakucom'});
    try {
      final result = await lastFmApiService.request(endpoint);
      return Result.success(result.toRecentTrackList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
