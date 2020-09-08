import 'package:flutter/material.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/widgets/add_comment.dart';
import 'package:news_feed/widgets/like_and_comment_buttons.dart';
import 'package:news_feed/widgets/post_section.dart';
import 'package:news_feed/widgets/user_post_info.dart';

import 'comments_list.dart';

class OpenPost extends StatefulWidget {
  final focus;
  final PostModel post;
  OpenPost({this.post, this.focus});

  @override
  _OpenPostState createState() => _OpenPostState();
}

class _OpenPostState extends State<OpenPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  BackButton(),
                  Flexible(child: UserPostInfo(post: widget.post)),
                ],
              ),
              PostSection(post: widget.post, haveAnOnTap: false),
              LikeAndCommentButtons(post: widget.post, onTapOnComment: () {}),
              AddComment(focus: widget.focus, post: widget.post),
              CommentsList(focus: widget.focus, thisPost: widget.post),
            ],
          ),
        ),
      ),
    );
  }
}
