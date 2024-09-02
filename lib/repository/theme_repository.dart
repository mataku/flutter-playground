import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/store/kv_store.dart';
import 'package:state_app/ui/theme/app_theme.dart';

final themeRepositoryProvider = Provider<ThemeRepository>(
    (ref) => ThemeRepositoryImpl(kvStore: ref.read(kvStoreProvider)));

abstract class ThemeRepository {
  Future<AppTheme> getCurrentTheme();
  Future<void> setTheme(AppTheme theme);
}

class ThemeRepositoryImpl implements ThemeRepository {
  final KVStore kvStore;

  const ThemeRepositoryImpl({
    required this.kvStore,
  });

  @override
  Future<AppTheme> getCurrentTheme() async {
    final currentThemeId = await kvStore.getStringValue(KVStoreKey.theme);
    final appTheme = AppTheme.values
            .firstWhereOrNull((value) => value.id == currentThemeId) ??
        AppTheme.dark;
    return appTheme;
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    await kvStore.setStringValue(KVStoreKey.theme, theme.id);
  }
}
