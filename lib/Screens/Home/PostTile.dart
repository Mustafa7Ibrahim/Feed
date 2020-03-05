import 'package:flutter/material.dart';
import 'package:news_feed/models/Post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Card(
        elevation: 12.0,
        // margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 26.0,
            ),
            SizedBox(height: 6),
            Text(
              post.name,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                post.content,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
