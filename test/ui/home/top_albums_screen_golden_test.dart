import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/api/response/user/top_albums_api_response.dart';
import 'package:sunrisescrob/model/recent_track/recent_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/user/top_album.dart';
import 'package:sunrisescrob/repository/recent_tracks_repository.dart';
import 'package:sunrisescrob/repository/user_repository.dart';
import 'package:sunrisescrob/ui/common/image/app_image_cache_manager.dart';
import 'package:sunrisescrob/ui/home/home_screen.dart';
import 'package:sunrisescrob/ui/home/scrobble_screen.dart';
import 'package:sunrisescrob/ui/home/top_albums_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../fixture.dart';
import '../../testable_app.dart';
import '../../util/mock_cache_manager.dart';
import 'scrobble_screen_golden_test.mocks.dart';
import 'top_albums_notifier_test.mocks.dart';

@GenerateMocks([RecentTracksRepository, UserRepository])
void main() {
  group('TopAlbumsScreen', () {
    late MockRecentTracksRepository mockRecentTracksRepository;
    late MockUserRepository mockUserRepository;

    setUp(() async {
      mockRecentTracksRepository = MockRecentTracksRepository();
      provideDummy<Result<List<RecentTrack>>>(Success(List.empty()));

      when(mockRecentTracksRepository.getRecentTracks(1)).thenAnswer((_) async {
        return Result.success(List.empty());
      });
      mockUserRepository = MockUserRepository();
      final response = fixture("user_top_albums.json");
      final albums = TopAlbumsApiResponse.fromJson(json.decode(response));
      provideDummy<Result<List<TopAlbum>>>(Success(albums.toTopAlbumList()));
      when(mockUserRepository.getTopAlbums(1)).thenAnswer((_) async {
        return Result.success(albums.toTopAlbumList());
      });
    });
    testGoldens('Dark', (tester) async {
      final notifier = TopAlbumsNotifier(userRepository: mockUserRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              scrobbleNotifierProvider.overrideWith((ref) {
                return ScrobbleNotifier(
                    recentTracksRepository: mockRecentTracksRepository);
              }),
              topAlbumsNotifier.overrideWith((ref) {
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
      // Go to top album tab
      await tester.tap(find.text('Album'));
      await notifier.fetchData();

      await tester.waitForAssets();

      await screenMatchesGolden(tester, 'top_albums_screen_dark');
    });

    testGoldens('Light', (tester) async {
      final notifier = TopAlbumsNotifier(userRepository: mockUserRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              scrobbleNotifierProvider.overrideWith((ref) {
                return ScrobbleNotifier(
                    recentTracksRepository: mockRecentTracksRepository);
              }),
              topAlbumsNotifier.overrideWith((ref) {
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
      // Go to top album tab
      await tester.tap(find.text('Album'));
      await notifier.fetchData();

      await tester.waitForAssets();

      await screenMatchesGolden(tester, 'top_albums_screen_light');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final notifier = TopAlbumsNotifier(userRepository: mockUserRepository);

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              scrobbleNotifierProvider.overrideWith((ref) {
                return ScrobbleNotifier(
                    recentTracksRepository: mockRecentTracksRepository);
              }),
              topAlbumsNotifier.overrideWith((ref) {
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
      // Go to top album tab
      await tester.tap(find.text('Album'));
      await notifier.fetchData();

      await tester.waitForAssets();

      await screenMatchesGolden(tester, 'top_albums_screen_lastfmdark');
    });
  });
}
