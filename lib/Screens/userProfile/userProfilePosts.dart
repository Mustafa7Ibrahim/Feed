import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Screens/Post/OpenPost.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/widgets/post_image.dart';

class UserProfilePosts extends StatefulWidget {
  final Post post;
  final User user;
  UserProfilePosts({this.post, this.user});

  @override
  _UserProfilePostsState createState() => _UserProfilePostsState();
}

class _UserProfilePostsState extends State<UserProfilePosts> {
  bool maxLines = true;

  @override
  Widget build(BuildContext context) {
    if (widget.post.ownerId == widget?.user?.userId ?? '') {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget?.post?.userProfileImg ??
                            'https://fakeimg.pl/350x200/?text=World&font=lobster',
                      ),
                    ),
                    title: Text(widget.post.userName),
                    subtitle: Text(
                      widget.post.timeStamp,
                    ),
                  ),
                  widget.post.mediaUrl != null
                      ? PostImage(imageUrl: widget.post.mediaUrl)
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      widget.post.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenPost(post: widget.post),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.comments),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OpenPost(
                            post: widget.post,
                            focus: true,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
