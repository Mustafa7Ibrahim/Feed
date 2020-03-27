import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_feed/Screens/OpenProfile/OpenProfile.dart';
import 'package:news_feed/Screens/Post/OpenPost.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/User.dart';

class ProfilePostTile extends StatelessWidget {
  final Post post;
  final User user;
  ProfilePostTile({this.post, this.user});
  bool maxLines = true;

  @override
  Widget build(BuildContext context) {
    if (post.ownerId == user.userId) {
      return Container(
        color: forgroungColor,
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
                      backgroundImage: NetworkImage(post.userProfileImg),
                    ),
                    title: Text(
                      post.userName,
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      post.timeStamp,
                      style: TextStyle(color: textColor),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OpenProfile(postUserId: post.ownerId)));
                    },
                    trailing: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: textColor,
                      ),
                      onPressed: () {
                        // TODO show more
                      },
                    ),
                  ),
                  post.mediaUrl != null
                      ? Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Image.network(
                            post.mediaUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SpinKitFoldingCube(
                                      color: profileColor,
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 14.0),
                                    Text(
                                      'Loading Image...',
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      post.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OpenPost(post: post)),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      LineIcons.thumbs_o_up,
                      color: textColor,
                    ),
                    onPressed: () {
                      // TODO increase the like number
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      LineIcons.comments_o,
                      color: textColor,
                    ),
                    onPressed: () {
                      // TODO add new Comment
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
