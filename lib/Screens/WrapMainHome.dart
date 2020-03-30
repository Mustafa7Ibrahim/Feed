import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_feed/Screens/AddNewPost/AddNewPost.dart';
import 'package:news_feed/Constant/constant.dart';

import 'Home/Home.dart';
import 'Profile/profile.dart';
import 'chat/chat.dart';

class WrapMainHome extends StatefulWidget {
  @override
  _WrapMainHomeState createState() => _WrapMainHomeState();
}

class _WrapMainHomeState extends State<WrapMainHome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Chat(),
    AddNewPost(),
    Profile(),
    // Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: textColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    textColor: textColor,
                    iconColor: textColor,
                    backgroundColor: homeColor,
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chat',
                    textColor: textColor,
                    iconColor: textColor,
                    backgroundColor: chatColor,
                  ),
                  GButton(
                    icon: Icons.add,
                    text: 'New Post',
                    textColor: textColor,
                    iconColor: textColor,
                    backgroundColor: addPostColor,
                  ),
                  GButton(
                    icon: Icons.person,
                    iconColor: textColor,
                    text: 'Profile',
                    textColor: textColor,
                    backgroundColor: profileColor,
                  ),
                  // GButton(
                  //   icon: Icons.settings,
                  //   text: 'Settings',
                  //   textColor: textColor,
                  //   iconColor: textColor,
                  //   backgroundColor: settingsColor,
                  // ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
