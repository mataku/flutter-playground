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
}

class SessionChangeNotifier extends ChangeNotifier {
  // ignore: unused_field
  bool _isLoggedIn = false;

  SessionChangeNotifier();

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final sessionChangeNotifierProvider =
    ChangeNotifierProvider((ref) => SessionChangeNotifier());
