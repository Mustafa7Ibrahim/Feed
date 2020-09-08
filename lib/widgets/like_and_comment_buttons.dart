import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/services/like_services.dart';

class LikeAndCommentButtons extends StatelessWidget {
  const LikeAndCommentButtons({Key key, @required this.post, @required this.onTapOnComment})
      : super(key: key);

  final PostModel post;
  final Function onTapOnComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.thumbsUp,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    LikeServices().likePost(postID: post.postId);
                    // liked = !liked;
                  },
                ),
                Text('${post.likesNum ?? 0}')
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.comments, color: Colors.grey[400]),
                  onPressed: onTapOnComment,
                ),
                Text('${post.commentsNum ?? 0}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
