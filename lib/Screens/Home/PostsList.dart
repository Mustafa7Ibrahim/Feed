import 'package:flutter/material.dart';
import 'package:news_feed/Screens/Home/PostTile.dart';
import 'package:news_feed/models/Post.dart';
import 'package:provider/provider.dart';

class PostsList extends StatefulWidget {

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<List<Post>>(context) ?? [];
    return ListView.builder(
      itemCount: post.length,
      itemBuilder: (context, index) {
        return PostTile(post: post[index]);
      },
    );
  }
}