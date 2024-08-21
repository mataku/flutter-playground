import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/model/chart_artist.dart';
import 'package:state_app/model/chart_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/tag.dart';
import 'package:state_app/page/discover/discover_screen.dart';
import 'package:state_app/repository/chart_repository.dart';

import '../../fixtures/test_data.dart';
import 'discover_notifier_test.mocks.dart';

@GenerateMocks([ChartRepository])
void main() {
  group('tracks', () {
    late ChartRepository chartRepository;

    setUp(() {
      chartRepository = MockChartRepository();
      provideDummy<Result<List<ChartArtist>>>(Success(testChartArtistList));
      provideDummy<Result<List<ChartTrack>>>(Success(testChartTrackList));
      provideDummy<Result<List<Tag>>>(Success(testChartTagList));
    });

    test('request succeeded', () async {
      when(chartRepository.getChartTracksSample(1))
          .thenAnswer((_) async => Result.success(testChartTrackList));
      when(chartRepository.getChartArtistsSample(1))
          .thenAnswer((_) async => Result.success(testChartArtistList));
      when(chartRepository.getChartTagsSample(1))
          .thenAnswer((_) async => Result.success(testChartTagList));

      final notifier = DiscoverNotifier(chartRepository: chartRepository);
      await notifier.fetchCharts();
      expect(notifier.tracks.isNotEmpty, true);
      expect(notifier.artists.isNotEmpty, true);
      expect(notifier.tags.isNotEmpty, true);
    });

    test('request failed', () async {
      final exception = TimeoutException('timeout');
      when(chartRepository.getChartTracksSample(1))
          .thenAnswer((_) async => Result.failure(exception));
      when(chartRepository.getChartArtistsSample(1))
          .thenAnswer((_) async => Result.failure(exception));
      when(chartRepository.getChartTagsSample(1))
          .thenAnswer((_) async => Result.failure(exception));

      final notifier = DiscoverNotifier(chartRepository: chartRepository);
      await notifier.fetchCharts();
      expect(notifier.tracks.isEmpty, true);
      expect(notifier.artists.isEmpty, true);
      expect(notifier.tags.isEmpty, true);
    });
  });
}
