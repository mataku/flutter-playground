import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/api/response/artist/artist_info_api_response.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/artist/artist.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/repository/artist_repository.dart';
import 'package:sunrisescrob/ui/common/image/app_image_cache_manager.dart';
import 'package:sunrisescrob/ui/detail/artist_detail_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../fixture.dart';
import '../../testable_app.dart';
import '../../util/mock_cache_manager.dart';
import './artist_detail_screen_golden_test.mocks.dart';

@GenerateMocks([ArtistRepository])
void main() {
  late ArtistRepository artistRepository;
  late ArtistNotifier artistNotifier;

  setUp(() async {
    artistRepository = MockArtistRepository();
    final jsonMap = fixture('artist_get_info.json');
    final artist =
        ArtistInfoApiResponse.fromJson(json.decode(jsonMap)).toArtist();
    provideDummy<Result<Artist>>(Success(artist));
    when(artistRepository.getArtistInfo(artist: 'aespa')).thenAnswer((_) async {
      return Success(artist);
    });
    artistNotifier = ArtistNotifier(artistRepository: artistRepository);
  });

  testGoldens('Light', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [Device.iphone11],
      )
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            artistNotifierProvider.overrideWith((ref) {
              return artistNotifier;
            }),
            appImageCacheManagerProvider.overrideWithValue(MockCacheManager()),
          ],
          child: testableApp(
            child: const ArtistDetailScreen(
              artist: 'aespa',
              imageKey: 'aespa',
              imageUrl: '',
            ),
            appTheme: AppTheme.light,
          ),
        ),
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'artist_detail_screen_light');
  });

  testGoldens('Dark', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [Device.iphone11],
      )
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            artistNotifierProvider.overrideWith((ref) {
              return artistNotifier;
            }),
            appImageCacheManagerProvider.overrideWithValue(MockCacheManager()),
          ],
          child: testableApp(
            child: const ArtistDetailScreen(
              artist: 'aespa',
              imageKey: 'aespa',
              imageUrl: '',
            ),
            appTheme: AppTheme.dark,
          ),
        ),
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'artist_detail_screen_dark');
  });

  testGoldens('Last.fm Dark', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [Device.iphone11],
      )
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            artistNotifierProvider.overrideWith((ref) {
              return artistNotifier;
            }),
            appImageCacheManagerProvider.overrideWithValue(MockCacheManager()),
          ],
          child: testableApp(
            child: const ArtistDetailScreen(
              artist: 'aespa',
              imageKey: 'aespa',
              imageUrl: '',
            ),
            appTheme: AppTheme.lastfmDark,
          ),
        ),
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'artist_detail_screen_lastfmdark');
  });
}
