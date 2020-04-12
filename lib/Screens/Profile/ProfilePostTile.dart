import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Screens/Post/OpenPost.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/widgets/post_image.dart';

class ProfilePostTile extends StatelessWidget {
  final Post post;
  final User user;
  ProfilePostTile({this.post, this.user});

  @override
  Widget build(BuildContext context) {
    if (post.ownerId == user?.userId ?? '') {
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
                        post?.userProfileImg ??
                            'https://fakeimg.pl/350x200/?text=World&font=lobster',
                      ),
                    ),
                    title: Text(post.userName),
                    subtitle: Text(post.timeStamp),
                   
                  ),
                  post.mediaUrl != null
                      ? PostImage(imageUrl: post.mediaUrl)
                      : Container(),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Text(
                      post.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenPost(post: post),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.thumbsUp),
                    onPressed: () {
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.comments),
                    onPressed: () {
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
