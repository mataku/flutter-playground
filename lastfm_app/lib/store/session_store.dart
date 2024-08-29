import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sessionStoreProvider = Provider((ref) {
  final store = SessionStore();
  store.init();
  return store;
});

// TODO: flutter_secure_storage
class SessionStore {
  static SharedPreferences? _pref;
  static const _sessionKey = 'session_key';
  Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  String? getSessionKey() {
    return _pref?.getString(_sessionKey);
  }

  void setSessionKey(String sessionKey) {
    _pref?.setString(_sessionKey, sessionKey);
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
