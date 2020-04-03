import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_feed/Screens/AddNewPost/AddNewPost.dart';
import 'package:news_feed/Constant/constant.dart';

import 'Home/Home.dart';
import 'Profile/profile.dart';
import 'chat/chat.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
                activeColor: whiteColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    textColor: whiteColor,
                    backgroundColor: homeColor,
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Chat',
                    textColor: whiteColor,
                    backgroundColor: chatColor,
                  ),
                  GButton(
                    icon: Icons.add,
                    text: 'Add',
                    textColor: whiteColor,
                    backgroundColor: addPostColor,
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                    textColor: whiteColor,
                    backgroundColor: profileColor,
                  ),
                
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
