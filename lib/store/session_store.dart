import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sunrisescrob/store/kv_store.dart';

final sessionStoreProvider = Provider((ref) => SessionStore());

class SessionStore {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: false,
    ),
  );

  static const _sessionKey = 'session_key';

  Future<String?> getSessionKey() async {
    return await storage.read(key: _sessionKey);
  }

  Future<void> setSessionKey(String sessionKey) async {
    await storage.write(key: _sessionKey, value: sessionKey);
  }

  Future<void> clearSessionKey() async {
    await storage.delete(key: _sessionKey);
  }
}

class SessionChangeNotifier extends ChangeNotifier {
  final SessionStore _sessionStore;
  final KVStore _kvStore;

  // ignore: unused_field
  bool _isLoggedIn = false;

  SessionChangeNotifier({
    required SessionStore sessionStore,
    required KVStore kvStore,
  })  : _sessionStore = sessionStore,
        _kvStore = kvStore;

  Future<void> login({
    required String sessionKey,
    required String username,
  }) async {
    _isLoggedIn = true;
    await _sessionStore.setSessionKey(sessionKey);
    await _kvStore.setStringValue(KVStoreKey.username, username);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await _sessionStore.clearSessionKey();
    await _kvStore.clearStringValue(KVStoreKey.username);
    notifyListeners();
  }
}

final sessionChangeNotifierProvider = ChangeNotifierProvider(
  (ref) => SessionChangeNotifier(
    sessionStore: ref.read(sessionStoreProvider),
    kvStore: ref.read(kvStoreProvider),
  ),
);
