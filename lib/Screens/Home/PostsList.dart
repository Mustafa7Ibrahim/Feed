import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Screens/Home/PostTile.dart';
import 'package:news_feed/models/Post.dart';

import '../../models/Post.dart';

class PostsList extends StatefulWidget {
  final controller;
  PostsList({this.controller});
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: Post().getPosts,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: !snapshot.hasData
              ? Center(
                  child: SpinKitFoldingCube(
                    color: Theme.of(context).primaryColor,
                    size: 24.0,
                  ),
                )
              : ListView.builder(
                  controller: widget.controller,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return PostTile(post: snapshot.data[index]);
                  },
                ),
        );
      },
    );
  }
}
