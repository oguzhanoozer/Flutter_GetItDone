import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorThemeData with ChangeNotifier {
  ThemeData _greenThemeData = ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    accentColor: Colors.green,
    appBarTheme: AppBarTheme(color: Colors.green),
    textTheme: TextTheme(
        headline3: TextStyle(
      color: Colors.white,
      //fontSize: 20,
    )),
  );

  ThemeData _redThemeData = ThemeData(
    primaryColor: Colors.red,
    primarySwatch: Colors.red,
    scaffoldBackgroundColor: Colors.red,
    accentColor: Colors.red,
    appBarTheme: AppBarTheme(color: Colors.red),
    textTheme: TextTheme(
        headline3: TextStyle(
      color: Colors.white,
      //fontSize: 20,
    )),
  );

  ThemeData _selectedThemeData = ThemeData(
    primaryColor: Colors.green,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green,
    accentColor: Colors.green,
    appBarTheme: AppBarTheme(color: Colors.green),
    textTheme: TextTheme(
        headline3: TextStyle(
      color: Colors.white,
      //fontSize: 20,
    )),
  );

  bool _isGreen = true;
  static SharedPreferences _sharedPref;

  bool get isGreen => _isGreen;

  void switchTheme(bool selected) {
    // _selectedThemeData = selected ? _greenThemeData : _redThemeData;
    _isGreen = selected;
    saveThemeToSharePref(selected);
    notifyListeners();
  }

  ThemeData get selectedTheme => _isGreen ? _greenThemeData : _redThemeData;

  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveThemeToSharePref(bool value) async {
    _sharedPref.setBool("themeData", value);
  }

  void loadThemeFromSharePref() {
    _isGreen = _sharedPref.getBool("themeData") ?? true;
  }
}
