import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.cyan,
  accentColor: Colors.cyanAccent,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.black87,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black87),
    actionsIconTheme: IconThemeData(color: Colors.black87),
  ),
  iconTheme: IconThemeData(color: Colors.black87),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan,
  ),
  buttonColor: Colors.cyan,
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
  ),
  cursorColor: Colors.cyan,
  disabledColor: Colors.redAccent,
  errorColor: Colors.red,
  cardColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white,
    margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
