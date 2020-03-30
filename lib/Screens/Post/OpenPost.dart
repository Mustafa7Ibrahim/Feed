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
  final _key = GlobalKey<FormState>();
  String comment;

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
          widget.post.userName,
          style: TextStyle(color: textColor),
        ),
      ),
      body: Container(
        color: forgroungColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundImage: NetworkImage(widget.post.userProfileImg),
              //   ),
              //   title: Text(
              //     widget.post.userName,
              //     style: TextStyle(color: textColor),
              //   ),
              //   subtitle: Text(
              //     widget.post.timeStamp,
              //     style: TextStyle(color: textColor),
              //   ),
              //   onTap: () {
              //     // TODO add here to open user profile
              //   },
              //   trailing: IconButton(
              //     icon: Icon(Icons.more_vert, color: textColor),
              //     onPressed: () {
              //       // TODO show more
              //     },
              //   ),
              // ),
              // widget.post.mediaUrl != null
              //     ? Padding(
              //         padding: EdgeInsets.all(18.0),
              //         child: Image.network(
              //           widget.post.mediaUrl,
              //           loadingBuilder: (BuildContext context, Widget child,
              //               ImageChunkEvent loadingProgress) {
              //             if (loadingProgress == null) {
              //               return child;
              //             } else {
              //               return Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 children: <Widget>[
              //                   SpinKitFoldingCube(
              //                     color: profileColor,
              //                     size: 18.0,
              //                   ),
              //                   SizedBox(width: 14.0),
              //                   Text(
              //                     'Loading Image...',
              //                     style: TextStyle(color: textColor),
              //                   ),
              //                 ],
              //               );
              //             }
              //           },
              //         ),
              //       )
              //     : Container(),
              // Container(
              //   margin: EdgeInsets.all(14.0),
              //   child: Text(
              //     widget.post.description,
              //     style: TextStyle(fontSize: 16.0, color: textColor),
              //   ),
              // ),
              // buttons(),
              addComment(),
              CommentsList(thisPost: widget.post),
            ],
          ),
        ),
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
              icon: Icon(LineIcons.thumbs_o_up, color: textColor),
              onPressed: () {
                // TODO increase the like number
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(LineIcons.comments_o, color: textColor),
              onPressed: () {
                // TODO add new Comment
              },
            ),
          )
        ],
      ),
    );
  }

  addComment() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Form(
            key: _key,
            child: Container(
              height: 60.0,
              child: TextFormField(
                minLines: 1,
                initialValue: null,
                cursorColor: addPostColor,
                style: TextStyle(color: textColor),
                keyboardType: TextInputType.multiline,
                onChanged: (input) => setState(() => comment = input),
                decoration: InputDecoration(
                  hintText: 'Enter your Comment',
                  hintStyle: TextStyle(color: grayColor),
                  fillColor: forgroungColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: addPostColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: addPostColor, width: 2),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: addPostColor,
            ),
            child: IconButton(
              icon: showLoading == false
                  ? Icon(Icons.send)
                  : SpinKitFadingCircle(color: textColor),
              color: textColor,
              onPressed: () async {
                setState(() => showLoading = true);
                await comments.addNewComment(
                  postId: widget.post.ownerId + widget.post.timeStamp,
                  comment: comment,
                ).then((done) {
                  setState(() => showLoading = false);
                  _key.currentState.reset();
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
