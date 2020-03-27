import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';
import 'package:news_feed/Constant/constant.dart';

import 'ProfilePostTile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: User().currentUser,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                userInfo(context),
                SizedBox(height: 12.0),
                userPosts(context),
              ],
            ),
          ),
        );
      },
    );
  }

  userInfo(BuildContext context) {
    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        Center(
          child: SizedBox(
            height: 75.0,
            width: 75.0,
            child: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl), radius: 24.0,),
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(
            user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: textColor,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(
            user.email,
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 14.0, color: textColor),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: forgroungColor,
              ),
              child: IconButton(
                color: Colors.green[300],
                icon: Icon(LineIcons.comments_o),
                onPressed: () {
                  //TODO send message
                },
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: forgroungColor,
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
                color: forgroungColor,
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

  userPosts(BuildContext context) {
    final user = Provider.of<User>(context);
    return Expanded(
      child: StreamBuilder(
        stream: Post().getPosts,
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return ProfilePostTile(
                post: snapshot.data[index],
                user: user,
              );
            },
          );
        },
      ),
    );
  }
}
