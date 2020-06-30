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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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

      // Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         blurRadius: 20,
      //         color: Colors.black.withOpacity(.1),
      //       )
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //       child: GNav(
      //         gap: 8,
      //         activeColor: Colors.white,
      //         tabBackgroundColor: Theme.of(context).primaryColor,
      //         backgroundColor: Theme.of(context).primaryColorLight,
      //         iconSize: 24,
      //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //         duration: Duration(milliseconds: 500),
      //         tabs: [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Discovery',
      //             // textColor: whiteColor,
      //           ),
      //           GButton(
      //             icon: Icons.chat,
      //             text: 'Chat',
      //             // textColor: whiteColor,
      //           ),
      //           GButton(
      //             icon: Icons.add,
      //             text: 'Add',
      //             // textColor: whiteColor,
      //           ),
      //           GButton(
      //             icon: Icons.person,
      //             text: 'Profile',
      //             // textColor: whiteColor,
      //           ),
      //         ],
      //         selectedIndex: _selectedIndex,
      //         onTabChange: (index) {
      //           setState(() => _selectedIndex = index);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
