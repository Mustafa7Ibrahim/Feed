import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Screens/Post/CommentsList.dart';
import 'package:news_feed/Screens/Profile/profile.dart';
import 'package:news_feed/models/Comment.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/widgets/post_image.dart';

class OpenPost extends StatefulWidget {
  final focus;
  final Post post;
  OpenPost({this.post, this.focus});

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
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.post.userName),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  userinfo(),
                  widget.post.mediaUrl != null
                      ? PostImage(imageUrl: widget.post.mediaUrl)
                      : Container(),
                  Container(
                    margin: EdgeInsets.all(14.0),
                    child: Text(
                      widget.post.description,
                      // style: TextStyle(fontSize: 16.0, color: blackColor),
                    ),
                  ),
                  buttons(),
                  Container(
                    // color: backgroundColor,
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

  userinfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.post.userProfileImg),
      ),
      title: Text(widget.post.userName),
      subtitle: Text(widget.post.timeStamp),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(postUserId: widget.post.ownerId),
          ),
        );
      },
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          // TODO show more
        },
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
              icon: Icon(FontAwesomeIcons.thumbsUp),
              onPressed: () {
                // TODO increase the like number
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(FontAwesomeIcons.comments),
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
            focus: widget.focus,
          );
        },
      ),
    );
  }
}
