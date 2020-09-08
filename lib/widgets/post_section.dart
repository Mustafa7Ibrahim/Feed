import 'package:flutter/material.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/screens/post/open_post.dart';
import 'package:news_feed/widgets/post_image.dart';

class PostSection extends StatelessWidget {
  const PostSection({@required this.post, @required this.haveAnOnTap});

  final PostModel post;
  final bool haveAnOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () => haveAnOnTap
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenPost(post: post, focus: false),
                ),
              )
            : () {},
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
}
