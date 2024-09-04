import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/track_repository.dart';
import 'package:sunrisescrob/ui/detail/track_detail_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../fixtures/test_data.dart';
import '../../page/detail/track_notifier_test.mocks.dart';
import '../../testable_app.dart';

@GenerateMocks([TrackRepository])
void main() {
  group('TrackDetailScreen', () {
    late TrackNotifier trackNotifier;
    setUp(() async {
      provideDummy(Result.success(testTrackApiResponse.response.toTrack()));
      final repo = MockTrackRepository();
      when(repo.getTrackSample('Supernova', 'aespa')).thenAnswer((_) async {
        return Result.success(testTrackApiResponse.response.toTrack());
      });
      trackNotifier = TrackNotifier(trackRepository: repo);
    });

    testGoldens('Light', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              trackNotifierProvider.overrideWith((ref) => trackNotifier)
            ],
            child: testableApp(
              child: const TrackDetailScreen(
                artist: 'aespa',
                track: 'Supernova',
              ),
              appTheme: AppTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'track_detail_screen_light');
    });

    testGoldens('Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              trackNotifierProvider.overrideWith((ref) => trackNotifier)
            ],
            child: testableApp(
              child: const TrackDetailScreen(
                artist: 'aespa',
                track: 'Supernova',
              ),
              appTheme: AppTheme.dark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'track_detail_screen_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              trackNotifierProvider.overrideWith((ref) => trackNotifier)
            ],
            child: testableApp(
              child: const TrackDetailScreen(
                artist: 'aespa',
                track: 'Supernova',
              ),
              appTheme: AppTheme.lastfmDark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'track_detail_screen_lastfmdark');
    });
  });
}
