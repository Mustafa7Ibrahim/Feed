import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';

class OpenPost extends StatefulWidget {
  final Post post;
  OpenPost({this.post});

  @override
  _OpenPostState createState() => _OpenPostState(openPost: post);
}

class _OpenPostState extends State<OpenPost> {
  final Post openPost;
  _OpenPostState({this.openPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: textColor,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text(
          openPost.userName,
          style: TextStyle(color: textColor),
        ),
      ),
      body: Container(
        color: forgroungColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(openPost.userProfileImg),
              ),
              title: Text(
                openPost.userName,
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                openPost.timeStamp,
                style: TextStyle(color: textColor),
              ),
              onTap: () {
                // TODO add here to open user profile
              },
              trailing: IconButton(
                icon: Icon(Icons.more_vert, color: textColor),
                onPressed: () {
                  // TODO show more
                },
              ),
            ),
            openPost.mediaUrl != null
                ? Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Image.network(
                      openPost.mediaUrl,
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
                left: 14.0,
                right: 14.0,
                bottom: 16.0,
              ),
              child: Text(
                openPost.description,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: textColor,
                ),
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
      ),
    );
  }
}
