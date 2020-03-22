import 'package:flutter/material.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Screens/Home/PostsList.dart';
import 'package:news_feed/Screens/NewPost/newPost.dart';
import 'package:news_feed/Screens/Profile/profile.dart';
import 'package:news_feed/models/Post.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'News Feed',
            style: TextStyle(color: Colors.grey),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.check_box_outline_blank, color: Colors.black),
            onPressed: () => auth.signOutGoogle(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPost()),
            );
          },
          child: Icon(Icons.add, size: 35),
          backgroundColor: Colors.blueGrey,
        ),
        // the list of posts
        body: PostsList(),
      ),
    );
  }
}
