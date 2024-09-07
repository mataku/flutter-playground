import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kvStoreProvider = Provider((ref) => KVStore());

class KVStore {
  static SharedPreferences? _pref;

  Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  Future<void> setStringValue(
    KVStoreKey key,
    String value,
  ) async {
    await _pref?.setString(key.key, value);
  }

  Future<String> getStringValue(
    KVStoreKey key,
  ) async {
    return _pref?.getString(key.key) ?? '';
  }

  Future<void> clearStringValue(KVStoreKey key) async {
    await _pref?.remove(key.key);
  }
}

enum KVStoreKey {
  theme(key: 'theme'),
  username(key: 'username');

  const KVStoreKey({
    required this.key,
  });

  final String key;
}
