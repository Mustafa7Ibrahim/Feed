import 'package:flutter/material.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/screens/post/open_post.dart';
import 'package:news_feed/widgets/post_section.dart';
import 'package:news_feed/widgets/user_post_info.dart';

import 'like_and_comment_buttons.dart';

class PostTile extends StatelessWidget {
  final PostModel post;
  final bool focus;
  PostTile({this.post, this.focus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserPostInfo(post: post),
        PostSection(post: post, haveAnOnTap: true),
        LikeAndCommentButtons(
          post: post,
          onTapOnComment: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OpenPost(post: post, focus: true),
              ),
            );
          },
        ),
      ],
    );
  }
}
