import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:sunrisescrob/repository/auth_repository.dart';
import 'package:sunrisescrob/ui/auth/login_screen.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import '../../testable_app.dart';
import 'login_screen_golden_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('LoginScreen', () {
    late LoginNotifier loginNotifier;
    setUp(() async {
      final repo = MockAuthRepository();
      loginNotifier = LoginNotifier(authRepository: repo);
    });

    testGoldens('Light', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              loginNotifierProvider.overrideWith((ref) {
                return loginNotifier;
              })
            ],
            child: testableApp(
              child: LoginScreen(),
              appTheme: AppTheme.light,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'login_screen_light');
    });

    testGoldens('Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              loginNotifierProvider.overrideWith((ref) {
                return loginNotifier;
              })
            ],
            child: testableApp(
              child: LoginScreen(),
              appTheme: AppTheme.dark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'login_screen_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: ProviderScope(
            overrides: [
              loginNotifierProvider.overrideWith((ref) {
                return loginNotifier;
              })
            ],
            child: testableApp(
              child: LoginScreen(),
              appTheme: AppTheme.lastfmDark,
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'login_screen_lastfmdark');
    });
  });
}
