import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/api/endpoint/chart_top_artists_endpoint.dart';
import 'package:state_app/api/endpoint/chart_top_tags_endpoint.dart';
import 'package:state_app/api/endpoint/chart_top_tracks_endpoint.dart';
import 'package:state_app/api/last_fm_api_service.dart';
import 'package:state_app/api/response/chart_top_artists_api_response.dart';
import 'package:state_app/api/response/chart_top_tags_api_response.dart';
import 'package:state_app/api/response/chart_top_tracks_api_response.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/model/app_error.dart';
import 'package:state_app/model/chart_artist.dart';
import 'package:state_app/model/chart_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/tag.dart';

abstract class ChartRepository {
  Future<Result<List<ChartArtist>>> getChartArtists(int page);
  Future<Result<List<ChartArtist>>> getChartArtistsSample(int page);

  Future<Result<List<ChartTrack>>> getChartTracks(int page);
  Future<Result<List<ChartTrack>>> getChartTracksSample(int page);
  Future<Result<List<Tag>>> getChartTags(int page);
  Future<Result<List<Tag>>> getChartTagsSample(int page);
}

final chartRepositoryProvider = Provider((ref) =>
    ChartRepositoryImpl(lastFmApiService: ref.read(lastFmApiServiceProvider)));

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
  Future<Result<List<ChartArtist>>> getChartArtistsSample(int page) async {
    final data =
        await rootBundle.loadString("asset/json/chart_top_artists.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final artists = ChartTopArtistsApiResponse.fromJson(result);
    return Result.success(artists.toChartArtistList());
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
  Future<Result<List<ChartTrack>>> getChartTracksSample(int page) async {
    final data =
        await rootBundle.loadString("asset/json/chart_top_tracks.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final tracks = ChartTopTracksApiResponse.fromJson(result);
    return Result.success(tracks.toChartTrackList());
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

  @override
  Future<Result<List<Tag>>> getChartTagsSample(int page) async {
    final data = await rootBundle.loadString("asset/json/chart_top_tags.json");
    final result = json.decode(data) as Map<String, dynamic>;
    final tags = ChartTopTagsApiResponse.fromJson(result);
    return Result.success(tags.toTagList());
  }
}
