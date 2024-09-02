import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/api/response/mapper/response_mapper.dart';
import 'package:state_app/api/response/profile/user_get_info_api_response.dart';
import 'package:state_app/model/profile/user_info.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/profile_repository.dart';
import 'package:state_app/repository/theme_repository.dart';
import 'package:state_app/ui/account/account_screen.dart';
import 'package:state_app/ui/common/image/app_image_cache_manager.dart';
import 'package:state_app/ui/common/theme_notifier.dart';
import 'package:state_app/ui/theme/app_theme.dart';

import '../../fixture.dart';
import '../../testable_app.dart';
import '../../util/mock_cache_manager.dart';
import 'account_screen_golden_test.mocks.dart';

@GenerateMocks([ProfileRepository, ThemeRepository])
void main() {
  group('AccountScreen', () {
    late AccountNotifier accountNotifier;
    late ThemeNotifier themeNotifier;

    setUp(() async {
      final jsonMap = fixture('user_get_info.json');
      final userInfo = UserGetInfoApiResponse.fromJson(json.decode(jsonMap));
      provideDummy<Result<UserInfo>>(Success(userInfo.response.toUserInfo()));
      final profileRepository = MockProfileRepository();
      when(profileRepository.getUserInfoSample()).thenAnswer((_) async {
        return Result.success(userInfo.response.toUserInfo());
      });
      accountNotifier = AccountNotifier(profileRepository: profileRepository);
      final themeRepository = MockThemeRepository();
      when(themeRepository.getCurrentTheme()).thenAnswer((_) async {
        return AppTheme.light;
      });
      themeNotifier = ThemeNotifier(themeRepository);
    });

    testGoldens('Light', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              accountNotifierProvider.overrideWith((ref) {
                return accountNotifier;
              }),
              themeNotifierProvider.overrideWith((ref) {
                return themeNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const AccountScreen(),
              appTheme: AppTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await accountNotifier.fetchUserInfo();

      await screenMatchesGolden(tester, 'account_screen_light');
    });

    testGoldens('Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              accountNotifierProvider.overrideWith((ref) {
                return accountNotifier;
              }),
              themeNotifierProvider.overrideWith((ref) {
                return themeNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const AccountScreen(),
              appTheme: AppTheme.dark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await accountNotifier.fetchUserInfo();

      await screenMatchesGolden(tester, 'account_screen_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              accountNotifierProvider.overrideWith((ref) {
                return accountNotifier;
              }),
              themeNotifierProvider.overrideWith((ref) {
                return themeNotifier;
              }),
              appImageCacheManagerProvider
                  .overrideWithValue(MockCacheManager()),
            ],
            child: testableApp(
              child: const AccountScreen(),
              appTheme: AppTheme.lastfmDark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await accountNotifier.fetchUserInfo();

      await screenMatchesGolden(tester, 'account_screen_lastfmdark');
    });
  });
}
