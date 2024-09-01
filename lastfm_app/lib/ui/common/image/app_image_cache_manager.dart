import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appImageCacheManagerProvider =
    Provider<CacheManager>((ref) => AppImageCacheManager());

class AppImageCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'appImageCache';

  static final AppImageCacheManager _instance = AppImageCacheManager._();

  factory AppImageCacheManager() {
    return _instance;
  }

  AppImageCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 1000,
          ),
        );
}
