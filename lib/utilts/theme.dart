import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primarySwatch: Colors.lightBlue,
  accentColor: Colors.greenAccent,
  scaffoldBackgroundColor: Colors.white,
  bottomAppBarColor: Colors.black87,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black87),
    actionsIconTheme: IconThemeData(color: Colors.black87),
    // textTheme: TextTheme(
    //   title: TextStyle(
    //     color: Colors.black87,
    //     fontSize: 20.0,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
  ),
  // primaryTextTheme: TextTheme(
  //   // text of time
  //   body1: TextStyle(
  //     color: Colors.black87,
  //     fontSize: 12.0,
  //   ),

  //   // title in some element
  //   subhead: TextStyle(
  //     fontSize: 16.0,
  //   ),
  // ),
  iconTheme: IconThemeData(color: Colors.black87),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.greenAccent,
  ),
  buttonColor: Colors.greenAccent,
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
  ),
  cursorColor: Colors.greenAccent,
  disabledColor: Colors.redAccent,
  errorColor: Colors.red,
  cardColor: Colors.white,
  cardTheme: CardTheme(
    // elevation: 1.0,
    color: Colors.white,
    margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
