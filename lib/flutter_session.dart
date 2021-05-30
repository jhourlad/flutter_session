/// Copyright (c) 2020, Jhourlad Estrella.
/// All rights reserved. Use of this source code is governed by a
/// MIT-style license that can be found in the LICENSE.md file.

/// flutter_session file package.
///
/// Adds session-like functionality to Flutter
library flutter_session;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// flutter_session
/// A package that adds session functionality to Flutter
class FlutterSession {
  /// Initialize session container
  Map _session = {};

  // Yes, it uses SharedPreferences
  SharedPreferences prefs;

  // Initialize the SharedPreferences instance
  Future _initSharedPrefs() async {
    this.prefs = await SharedPreferences.getInstance();
  }

  /// Item remover
  ///
  /// @param key String
  /// @returns Future
  Future remove(key) async{
    await _initSharedPrefs();
    return this.prefs.remove(key);
  }

  /// Session cleaner
  ///
  /// @returns Future
  Future clear() async{
    await _initSharedPrefs();
    return this.prefs.clear();
  }

  /// Item setter
  ///
  /// @param key String
  /// @returns Future
  Future get(key) async {
    await _initSharedPrefs();
    try {
      return json.decode(this.prefs.get(key));
    } catch (e) {
      return this.prefs.get(key);
    }
  }

  /// Item setter
  ///
  /// @param key String
  /// @param value any
  /// @returns Future
  Future set(key, value) async {
    await _initSharedPrefs();

    // Detect item type
    switch (value.runtimeType) {
      // String
      case String:
        {
          this.prefs.setString(key, value);
        }
        break;

      // Integer
      case int:
        {
          this.prefs.setInt(key, value);
        }
        break;

      // Boolean
      case bool:
        {
          this.prefs.setBool(key, value);
        }
        break;

      // Double
      case double:
        {
          this.prefs.setDouble(key, value);
        }
        break;

      // List<String>
      case List:
        {
          this.prefs.setStringList(key, value);
        }
        break;

      // Object
      default:
        {
          this.prefs.setString(key, jsonEncode(value.toJson()));
        }
    }

    // Add item to session container
    this._session.putIfAbsent(key, () => value);
  }
}
