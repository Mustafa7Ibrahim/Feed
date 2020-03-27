import 'package:flutter/material.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Screens/Home/PostsList.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: Post().getPosts,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          title: Text('Home', style: TextStyle(color: textColor)),

          // FlatButton(
          //   child: CircleAvatar(
          //     backgroundImage: NetworkImage(user.photoUrl),
          //     radius: 18.0,
          //   ),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Profile(),
          //     ),
          //   ),
          // ),
          centerTitle: true,
          // leading: IconButton(
          //   icon: Icon(Icons.check_box_outline_blank, color: Colors.black),
          //   onPressed: () async => auth.signOutGoogle(),
          // ),
          // actions: <Widget>[
          //   FlatButton(
          //     child: CircleAvatar(
          //       backgroundImage: NetworkImage(user.photoUrl),
          //       radius: 18.0,
          //     ),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Profile(),
          //       ),
          //     ),
          //   ),
          // IconButton(
          //   icon: Icon(Icons.more_vert, color: Colors.black),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Profile(),
          //     ),
          //   ),
          // ),
          // ],
        ),
        // the list of posts
        body: PostsList(),
      ),
    );
  }
}
