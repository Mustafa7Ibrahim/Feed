import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Screens/Home/PostTile.dart';
import 'package:news_feed/models/Post.dart';
import 'package:provider/provider.dart';

class PostsList extends StatefulWidget {
  final controller;
  PostsList({this.controller});
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final _post = Provider.of<List<Post>>(context) ?? [];
    return _post.length != 0
        ? ListView.builder(
            controller: widget.controller,
            itemCount: _post.length,
            itemBuilder: (context, index) {
              return PostTile(post: _post[index] );
            },
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SpinKitFoldingCube(
                color: Theme.of(context).accentColor,
                size: 24.0,
              ),
              SizedBox(height: 8.0),
              Text('Loading'),
            ],
          );
  }
}
