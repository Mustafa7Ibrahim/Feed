import 'package:flutter/material.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Screens/Home/PostsList.dart';
import 'package:news_feed/Screens/NewPost/newPost.dart';
import 'package:news_feed/services/PostCollection.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: PostCollection().posts,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Feed'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () => auth.signOut(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPost(),
            ),
          ),
          child: Icon(Icons.add, size: 35),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Colors.white,
        body: PostsList(),
      ),
    );
  }
}
