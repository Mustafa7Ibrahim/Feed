import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeData themeData;

  AppThemeProvider({this.themeData});

  getTheme() => themeData;

  setTheme(ThemeData theme) {
    themeData = theme;
    notifyListeners();
  }

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.deepPurpleAccent,
    scaffoldBackgroundColor: Colors.grey[50],
    cursorColor: Colors.deepPurpleAccent,
    buttonColor: Colors.deepPurpleAccent,
    brightness: Brightness.light,

    // color of floating action in light theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurpleAccent,
    ),

    // color of the icons
    iconTheme: IconThemeData(color: Colors.black87),

    // appbar in light theme
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.white,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.black87),
      actionsIconTheme: IconThemeData(color: Colors.black87),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.deepPurpleAccent,
    scaffoldBackgroundColor: Colors.grey[850],
    cursorColor: Colors.deepPurpleAccent,
    buttonColor: Colors.deepPurpleAccent,
    brightness: Brightness.dark,

    // color of floating action in dark theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurpleAccent,
    ),

    // color of the icons
    iconTheme: IconThemeData(color: Colors.white),

    // appbar in dark theme
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.grey[900],
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
