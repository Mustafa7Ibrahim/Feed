import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/widgets/post_tile.dart';
import '../../models/post_model.dart';

class PostsList extends StatefulWidget {
  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: PostModel().getPosts,
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
