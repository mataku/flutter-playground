import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  // ignore: unused_field
  bool _isLoggedIn = false;

  SessionChangeNotifier({
    required SessionStore sessionStore,
  }) : _sessionStore = sessionStore;

  Future<void> login(String sessionKey) async {
    _isLoggedIn = true;
    await _sessionStore.setSessionKey(sessionKey);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await _sessionStore.clearSessionKey();
    notifyListeners();
  }
}

final sessionChangeNotifierProvider = ChangeNotifierProvider((ref) =>
    SessionChangeNotifier(sessionStore: ref.read(sessionStoreProvider)));
