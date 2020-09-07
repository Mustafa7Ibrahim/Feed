import 'package:flutter/material.dart';

class PopUpMenu {
  static const String settings = 'Settings';
  static const String signOut = 'SignOut';

  static const List<String> choices = <String>[
    settings,
    signOut,
  ];
  static const List<Icon> icons = <Icon>[
    Icon(Icons.settings),
    Icon(Icons.check_box_outline_blank),
  ];
}
