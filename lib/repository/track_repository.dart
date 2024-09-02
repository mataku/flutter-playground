import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sunrisescrob/api/endpoint/track_info_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/track/track_info_api_response.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/track.dart';

final trackRepositoryProvider =
    Provider((ref) => TrackRepositoryImpl(ref.read(lastFmApiServiceProvider)));

abstract class TrackRepository {
  Future<Result<Track>> getTrack(String track, String artist);
  Future<Result<Track>> getTrackSample(String track, String artist);
}

class TrackRepositoryImpl implements TrackRepository {
  final LastFmApiService _lastFmApiService;

  const TrackRepositoryImpl(this._lastFmApiService);

  @override
  Future<Result<Track>> getTrack(String track, String artist) async {
    final endpoint = TrackInfoEndpoint(
      params: {
        'artist': artist,
        'track': track,
      },
    );
    try {
      final response = await _lastFmApiService.request(endpoint);
      return Result.success(response.toTrack());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<Track>> getTrackSample(String track, String artist) async {
    try {
      final data =
          await rootBundle.loadString("asset/json/track_get_info.json");
      final result = json.decode(data) as Map<String, dynamic>;
      final track = TrackInfoApiResponse.fromJson(result);
      return Result.success(track.toTrack());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
