import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:state_app/api/endpoint/track_info_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/track_info_api_response.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/track.dart';

abstract class TrackRepository {
  Future<Result<Track>> getTrack(String track, String artist);
  Future<Result<Track>> getTrackSample(String track, String artist);
}

class TrackRepositoryImpl implements TrackRepository {
  final LastFmApiService lastFmApiService;

  TrackRepositoryImpl({required this.lastFmApiService});

  @override
  Future<Result<Track>> getTrack(String track, String artist) async {
    final endpoint = TrackInfoEndpoint(
      params: {
        'artist': artist,
        'track': track,
      },
    );
    try {
      final response = await lastFmApiService.request(endpoint);
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
      debugPrint("MATAKUDEBUG error: $error");
      return Result.failure(AppError.getApiError(error));
    }
  }
}
