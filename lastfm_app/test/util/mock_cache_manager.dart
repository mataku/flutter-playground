import 'package:file/local.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mockito/mockito.dart';

class MockCacheManager extends Mock implements CacheManager {
  final system = const LocalFileSystem();

  @override
  Stream<FileResponse> getFileStream(String url,
      {String? key,
      Map<String, String>? headers,
      bool withProgress = false}) async* {
    yield FileInfo(
      system.file('test/fixtures/kota.png'),
      FileSource.Cache,
      DateTime(2100),
      url,
    );
  }

  @override
  Future<FileInfo> downloadFile(String url,
      {String? key,
      Map<String, String>? authHeaders,
      bool force = false}) async {
    return FileInfo(
      system.file('test/fixtures/kota.png'),
      FileSource.Cache,
      DateTime.now(),
      url,
    );
  }

  @override
  Future<FileInfo?> getFileFromCache(String key,
      {bool ignoreMemCache = false}) async {
    return FileInfo(
      system.file('test/fixtures/kota.png'),
      FileSource.Cache,
      DateTime(2100),
      key,
    );
  }
}
