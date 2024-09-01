import 'dart:async';
import 'dart:io';

import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      // final regular = rootBundle.load('asset/font/NotoSansJP-Regular.ttf');

      // final loader = FontLoader('Noto Sans JP')..addFont(regular);
      // await loader.load();
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      skipGoldenAssertion: () {
        return Platform.isIOS || Platform.isAndroid;
      },
      defaultDevices: const [
        Device.iphone11,
      ],
    ),
  );
}
