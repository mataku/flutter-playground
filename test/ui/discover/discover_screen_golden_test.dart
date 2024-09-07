import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/model/chart/chart_artist.dart';
import 'package:sunrisescrob/model/chart/chart_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/tag.dart';
import 'package:sunrisescrob/repository/chart_repository.dart';
import 'package:sunrisescrob/ui/common/image/app_image_cache_manager.dart';
import 'package:sunrisescrob/ui/discover/discover_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../fixtures/test_data.dart';
import '../../testable_app.dart';
import '../../util/mock_cache_manager.dart';
import 'discover_screen_golden_test.mocks.dart';

@GenerateMocks([ChartRepository])
void main() {
  group('DiscoverScreen', () {
    late DiscoverNotifier discoverNotifier;
    setUp(() async {
      provideDummy<Result<List<ChartArtist>>>(Success(testChartArtistList));
      provideDummy<Result<List<ChartTrack>>>(Success(testChartTrackList));
      provideDummy<Result<List<Tag>>>(Success(testChartTagList));

      final chartRepository = MockChartRepository();
      when(chartRepository.getChartTracks(1))
          .thenAnswer((_) async => Result.success(testChartTrackList));
      when(chartRepository.getChartArtists(1))
          .thenAnswer((_) async => Result.success(testChartArtistList));
      when(chartRepository.getChartTags(1))
          .thenAnswer((_) async => Result.success(testChartTagList));

      discoverNotifier = DiscoverNotifier(chartRepository: chartRepository);
    });
    testGoldens('Light', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              discoverNotifierProvider.overrideWith((ref) {
                return discoverNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const DiscoverScreen(),
              appTheme: AppTheme.light,
            ),
          ),
        );
      await tester.pumpDeviceBuilder(builder);

      await discoverNotifier.fetchCharts();

      await screenMatchesGolden(tester, 'discover_screen_light');
    });

    testGoldens('Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              discoverNotifierProvider.overrideWith((ref) {
                return discoverNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const DiscoverScreen(),
              appTheme: AppTheme.dark,
            ),
          ),
        );
      await tester.pumpDeviceBuilder(builder);

      await discoverNotifier.fetchCharts();

      await screenMatchesGolden(tester, 'discover_screen_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              discoverNotifierProvider.overrideWith((ref) {
                return discoverNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const DiscoverScreen(),
              appTheme: AppTheme.lastfmDark,
            ),
          ),
        );
      await tester.pumpDeviceBuilder(builder);

      await discoverNotifier.fetchCharts();

      await screenMatchesGolden(tester, 'discover_screen_lastfmdark');
    });
  });
}
