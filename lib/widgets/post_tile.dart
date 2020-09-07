import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/screens/post/open_post.dart';
import 'package:news_feed/widgets/post_image.dart';
import 'package:news_feed/widgets/user_post_info.dart';

import '../models/user_model.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  final bool focus;
  final UserModel user;
  PostTile({this.post, this.focus, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserPostInfo(post: post),
        postSection(context),
        rowButtons(context),
      ],
    );
  }

  postSection(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.color,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenPost(post: post, focus: false),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            post.mediaUrl != null ? PostImage(imageUrl: post.mediaUrl) : Container(),
            Container(
              margin: EdgeInsets.all(12.0),
              child: Text(
                post.description,
                maxLines: 7,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  rowButtons(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.color,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.thumbsUp, color: Colors.grey[400]),
              onPressed: () {},
            ),
          ),
          Divider(thickness: 3),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.comments, color: Colors.grey[400]),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OpenPost(post: post, focus: true),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
