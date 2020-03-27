import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/User.dart';

class OpenProfile extends StatefulWidget {
  final String postUserId;
  OpenProfile({this.postUserId});

  @override
  _OpenProfileState createState() => _OpenProfileState();
}

class _OpenProfileState extends State<OpenProfile> {
  User _user = User();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: userCollection
            .document(widget.postUserId)
            .snapshots()
            .map(_user.getUserData),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: forgroungColor,
            body: SafeArea(
              child: Center(
                child: userInfo(context, snapshot),
              ),
            ),
          );
        });
  }

  Widget userInfo(BuildContext context, AsyncSnapshot snapshot) {
    // final user = Provider.of<User>(context);
    return ListView(
      children: <Widget>[
        SizedBox(height: 20.0),
        Center(
          child: SizedBox(
            height: 100.0,
            width: 100.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data['imageUrl'] ?? null),
              radius: 24.0,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Text(
            snapshot.data.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(
            snapshot.data.email,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: forgroungColor,
              ),
              child: IconButton(
                color: Colors.green[300],
                icon: Icon(FontAwesomeIcons.sms),
                onPressed: () {
                  //TODO send message
                },
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.white,
              ),
              child: IconButton(
                color: Colors.blueAccent,
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
                color: Colors.white,
              ),
              child: IconButton(
                color: Colors.blue,
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
