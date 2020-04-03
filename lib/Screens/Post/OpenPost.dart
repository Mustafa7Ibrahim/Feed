import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_feed/Screens/Post/CommentsList.dart';
import 'package:news_feed/models/Comment.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';

class OpenPost extends StatefulWidget {
  final Post post;
  OpenPost({this.post});

  @override
  _OpenPostState createState() => _OpenPostState();
}

class _OpenPostState extends State<OpenPost> {
  Comment comments = Comment();
  bool showLoading = false;
  String comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: homeColor,
        elevation: 0.0,
        title: Text(
          widget.post.userName,
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              color: forgroungColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(widget.post.userProfileImg),
                    ),
                    title: Text(
                      widget.post.userName,
                      style: TextStyle(color: blackColor),
                    ),
                    subtitle: Text(
                      widget.post.timeStamp,
                      style: TextStyle(color: blackColor),
                    ),
                    onTap: () {
                      // TODO add here to open user profile
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert, color: blackColor),
                      onPressed: () {
                        // TODO show more
                      },
                    ),
                  ),
                  widget.post.mediaUrl != null
                      ? Hero(
                          tag: 'postPhoto',
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                            child: SizedBox(
                              height: 400.0,
                              width: double.infinity,
                              child: Image.network(
                                widget.post.mediaUrl,
                                fit: BoxFit.fitWidth,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress,
                                ) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SpinKitFoldingCube(
                                          color: homeColor,
                                          size: 18.0,
                                        ),
                                        SizedBox(width: 14.0),
                                        Text(
                                          'Loading Image...',
                                          style: TextStyle(color: blackColor),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                      margin: EdgeInsets.all(14.0),
                      child: Text(
                        widget.post.description,
                        style: TextStyle(fontSize: 16.0, color: blackColor),
                      ),
                    ),
                  buttons(),
                  Container(
                    color: backgroundColor,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ],
              ),
            ),
          ),
          commentsSection(),
        ],
      ),
    );
  }

  buttons() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(LineIcons.thumbs_o_up, color: blackColor),
              onPressed: () {
                // TODO increase the like number
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(LineIcons.comments_o, color: blackColor),
              onPressed: () async {},
            ),
          )
        ],
      ),
    );
  }

  commentsSection() {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        minChildSize: 0.2,
        maxChildSize: 1.0,
        initialChildSize: 0.2,
        builder: (context, scrollController) {
          return CommentsList(
            thisPost: widget.post,
            scrollController: scrollController,
          );
        },
      ),
    );
  }
}
