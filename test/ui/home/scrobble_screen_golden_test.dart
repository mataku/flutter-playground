import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/recent_track/recent_tracks_api_response.dart';
import 'package:state_app/model/recent_track/recent_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/recent_tracks_repository.dart';
import 'package:state_app/ui/common/image/app_image_cache_manager.dart';
import 'package:state_app/ui/home/home_screen.dart';
import 'package:state_app/ui/home/scrobble_screen.dart';
import 'package:state_app/ui/theme/app_theme.dart';

import '../../fixture.dart';
import '../../testable_app.dart';
import '../../util/mock_cache_manager.dart';
import 'scrobble_screen_golden_test.mocks.dart';

@GenerateMocks([RecentTracksRepository])
void main() {
  group('ScrobbleScreen', () {
    late MockRecentTracksRepository mockRecentTracksRepository;
    setUp(() async {
      mockRecentTracksRepository = MockRecentTracksRepository();
      final jsonMap =
          json.decode(fixture('recent_tracks.json')) as Map<String, dynamic>;
      final response = RecentTracksApiResponse.fromJson(jsonMap);
      provideDummy<Result<List<RecentTrack>>>(
          Success(response.toRecentTrackList()));
      when(mockRecentTracksRepository.getRecentTracksSample(1))
          .thenAnswer((_) async {
        return Result.success(response.toRecentTrackList());
      });
    });
    testGoldens('Dark', (tester) async {
      final notifier =
          ScrobbleNotifier(recentTracksRepository: mockRecentTracksRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              recentTracksRepositoryProvider
                  .overrideWithValue(mockRecentTracksRepository),
              scrobbleNotifierProvider.overrideWith((ref) {
                return notifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const HomeScreen(),
              appTheme: AppTheme.dark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await notifier.fetchData();

      await screenMatchesGolden(tester, 'scrobble_screen_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final notifier =
          ScrobbleNotifier(recentTracksRepository: mockRecentTracksRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              recentTracksRepositoryProvider
                  .overrideWithValue(mockRecentTracksRepository),
              scrobbleNotifierProvider.overrideWith((ref) {
                return notifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const HomeScreen(),
              appTheme: AppTheme.lastfmDark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await notifier.fetchData();

      await screenMatchesGolden(tester, 'scrobble_screen_lastfmdark');
    });

    testGoldens('Light', (tester) async {
      final notifier =
          ScrobbleNotifier(recentTracksRepository: mockRecentTracksRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              recentTracksRepositoryProvider
                  .overrideWithValue(mockRecentTracksRepository),
              scrobbleNotifierProvider.overrideWith((ref) {
                return notifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const HomeScreen(),
              appTheme: AppTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await notifier.fetchData();

      await screenMatchesGolden(tester, 'scrobble_screen_light');
    });
  });
}
