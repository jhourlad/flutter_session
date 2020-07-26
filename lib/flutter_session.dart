library flutter_session;

import 'package:shared_preferences/shared_preferences.dart';

// Concession
// A package that adds session functionality to Flutter
class FlutterSession {
  // Initialize session container
  Map _session = {};

  // Yes, it uses SharedPreferences
  SharedPreferences prefs;

  // Initialize the SharedPreferences instance
  Future _initSharedPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  // Item getter
  Future get(key) async {
    await _initSharedPrefs();
    return this.prefs.get(key);
  }

  // Item setter
  Future set(key, value) async {
    await _initSharedPrefs();

    // Detect item type
    switch (value.runtimeType) {
      case String:
        {
          this.prefs.setString(key, value);
        }
        break;

      case int:
        {
          this.prefs.setInt(key, value);
        }
        break;

      case bool:
        {
          this.prefs.setBool(key, value);
        }
        break;

      case double:
        {
          this.prefs.setDouble(key, value);
        }
        break;

      case List:
        {
          this.prefs.setStringList(key, value);
        }
        break;
    }

    // Add item to session container
    this._session.putIfAbsent(key, () => value);
  }
}
