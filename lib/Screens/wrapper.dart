import 'package:flutter/material.dart';

import '../Screens/AddNewPost/AddNewPost.dart';
import 'Home/Home.dart';
import 'chat/chat.dart';
import 'userProfile/userProfile.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Chat(),
    AddNewPost(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 24.0,
        onTap: (index) => setState(() => _selectedIndex = index),
        currentIndex: _selectedIndex,
        elevation: 12.0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Discovery'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Caht'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('ADD'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
