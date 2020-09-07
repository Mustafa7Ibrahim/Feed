import 'package:flutter/material.dart';

import 'Home/Home.dart';
import 'Profile/profile.dart';
import 'add_new_post/add_new_post.dart';
import 'chat/chat.dart';

class Wrapper extends StatefulWidget {
  final String userId;

  Wrapper({@required this.userId});
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Home(),
      Chat(),
      AddNewPost(),
      Profile(postUserId: widget.userId, currentUser: true),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
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
