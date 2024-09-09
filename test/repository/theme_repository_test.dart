import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sunrisescrob/repository/theme_repository.dart';
import 'package:sunrisescrob/store/kv_store.dart';
import 'package:sunrisescrob/ui/theme/app_theme.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([KVStore])
void main() {
  late MockKVStore kvStore;
  late ProviderContainer providerContainer;
  group('ThemeRepository', () {
    setUp(() async {
      kvStore = MockKVStore();
      when(kvStore.getStringValue(KVStoreKey.theme)).thenAnswer((_) async {
        return AppTheme.lastfmDark.id;
      });
      providerContainer = ProviderContainer(
        overrides: [
          kvStoreProvider.overrideWithValue(kvStore),
        ],
      );
    });

    test('getCurrentTheme', () async {
      final repo = providerContainer.read(themeRepositoryProvider);
      final result = await repo.getCurrentTheme();
      expect(result == AppTheme.lastfmDark, true);
      verify(kvStore.getStringValue(KVStoreKey.theme)).called(1);
    });

    test('setTheme', () async {
      final repo = providerContainer.read(themeRepositoryProvider);
      await repo.setTheme(AppTheme.light);
      verify(kvStore.setStringValue(KVStoreKey.theme, AppTheme.light.id))
          .called(1);
    });
  });
}
