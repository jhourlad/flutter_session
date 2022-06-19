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
  final Map _session = {};

  // Yes, it uses SharedPreferences
  late SharedPreferences prefs;

  // Initialize the SharedPreferences instance
  Future _initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Item setter
  ///
  /// @param key String
  /// @returns Future
  Future get(key) async {
    await _initSharedPrefs();
    try {
      return json.decode(prefs.getString(key) ?? "");
    } catch (e) {
      return prefs.get(key);
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
          prefs.setString(key, value);
        }
        break;

    // Integer
      case int:
        {
          prefs.setInt(key, value);
        }
        break;

    // Boolean
      case bool:
        {
          prefs.setBool(key, value);
        }
        break;

    // Double
      case double:
        {
          prefs.setDouble(key, value);
        }
        break;

    // List<String>
      case List:
        {
          prefs.setStringList(key, value);
        }
        break;

    // Object
      default:
        {
          prefs.setString(key, jsonEncode(value.toJson()));
        }
    }

    // Add item to session container
    _session.putIfAbsent(key, () => value);
  }
}