// ignore: file_names

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.system;
  int _themeNo = 1;

  int get getThemeNo => _themeNo;
  set setThemeNo(int newNo) {
    _themeNo = newNo;
    notifyListeners();
  }

  bool get isLightTheme => _currentTheme == ThemeMode.light ? true : false;

  ThemeMode get getCurrentThemeMode => _currentTheme;

  set setThemeMode(ThemeMode changeTheme) {
    _currentTheme = changeTheme;
    notifyListeners();
  }
}

OutlineInputBorder border({required Color borderColor}) => OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 1),
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15), bottomRight: Radius.circular(15)));

class Themes {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      brightness: Brightness.light,
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder()
      }),
      colorScheme: const ColorScheme.light(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, fixedSize: const Size(138, 45))),
      useMaterial3: false,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: border(borderColor: Colors.grey),
        focusedBorder: border(borderColor: Colors.blue),
      ),
      primaryColor: Colors.blue);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, fixedSize: Size(138, 45))),
      primaryColor: Colors.white,
      useMaterial3: false,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          extendedTextStyle: TextStyle(fontSize: 17, color: Colors.white)),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: Colors.black,
        enabledBorder: border(borderColor: Colors.grey),
        focusedBorder: border(borderColor: Colors.blue),
      ),
      colorScheme: const ColorScheme.dark());
}
