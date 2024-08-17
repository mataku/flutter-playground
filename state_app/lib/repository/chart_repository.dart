import 'package:flutter/material.dart';
import 'package:state_app/api/endpoint/chart_top_artists_endpoint.dart';
import 'package:state_app/api/endpoint/chart_top_tags_endpoint.dart';
import 'package:state_app/api/endpoint/chart_top_tracks_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/chart_artist.dart';
import 'package:state_app/model/chart_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/tag.dart';

abstract class ChartRepository {
  Future<Result<List<ChartArtist>>> getChartArtists(int page);
  Future<Result<List<ChartTrack>>> getChartTracks(int page);
  Future<Result<List<Tag>>> getChartTags(int page);
}

class ChartRepositoryImpl implements ChartRepository {
  final LastFmApiService lastFmApiService;

  ChartRepositoryImpl({required this.lastFmApiService});

  @override
  Future<Result<List<ChartArtist>>> getChartArtists(int page) async {
    final endpoint = ChartTopArtistsEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await lastFmApiService.request(endpoint);
      return Result.success(result.toChartArtistList());
    } on Exception catch (error) {
      debugPrint("MATAKUDEBUG $error");
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<ChartTrack>>> getChartTracks(int page) async {
    final endpoint = ChartTopTracksEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await lastFmApiService.request(endpoint);
      return Result.success(result.toChartTrackList());
    } on Exception catch (error) {
      debugPrint("MATAKUDEBUG $error");
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<Tag>>> getChartTags(int page) async {
    final endpoint = ChartTopTagsEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await lastFmApiService.request(endpoint);
      return Result.success(result.toTagList());
    } on Exception catch (error) {
      debugPrint("MATAKUDEBUG $error");
      return Result.failure(AppError.getApiError(error));
    }
  }
}
