import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: User().currentUser,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {
                // TODO write is what happing
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                userInfo(context),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInfo(BuildContext context) {
    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 150.0,
          width: 150.0,
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
            radius: 24.0,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
        ),
        SizedBox(height: 10.0),
        Text(
          user.email,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.blueGrey,
              ),
              child: IconButton(
                color: Colors.white,
                icon: Icon(FontAwesomeIcons.sms),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.blueGrey,
              ),
              child: IconButton(
                color: Colors.white,
                icon: Icon(FontAwesomeIcons.facebookSquare),
                onPressed: () {
                  // TODO open facebook app page
                },
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.blueGrey,
              ),
              child: IconButton(
                color: Colors.white,
                icon: Icon(FontAwesomeIcons.linkedin),
                onPressed: () {
                  // TODO open linkedIn page
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
