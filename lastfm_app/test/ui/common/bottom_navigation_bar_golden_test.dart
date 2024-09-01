import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:state_app/ui/common/app_bottom_navigation_bar.dart';
import 'package:state_app/ui/theme/app_theme.dart';

import '../../testable_app.dart';
import 'bottom_navigation_bar_golden_test.mocks.dart';

@GenerateMocks([StatefulNavigationShell])
void main() {
  group('AppBottomNavigationBar', () {
    late StatefulNavigationShell navigationShell;
    setUp(() {
      navigationShell = MockStatefulNavigationShell();
      when(navigationShell.currentIndex).thenReturn(0);
    });

    testGoldens('Light', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: testableApp(
            child: Scaffold(
              bottomNavigationBar: AppBottomNavigationBar(
                navigationShell: navigationShell,
              ),
            ),
            appTheme: AppTheme.light,
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'bottom_navigation_bar_light');
    });

    testGoldens('Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: testableApp(
            child: Scaffold(
              bottomNavigationBar: AppBottomNavigationBar(
                navigationShell: navigationShell,
              ),
            ),
            appTheme: AppTheme.dark,
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'bottom_navigation_bar_dark');
    });

    testGoldens('Last.fm Dark', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [Device.iphone11],
        )
        ..addScenario(
          widget: testableApp(
            child: Scaffold(
              bottomNavigationBar: AppBottomNavigationBar(
                navigationShell: navigationShell,
              ),
            ),
            appTheme: AppTheme.lastfmDark,
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'bottom_navigation_bar_lastfmdark');
    });
  });
}
