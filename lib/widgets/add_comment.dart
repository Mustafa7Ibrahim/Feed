import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/models/comment_model.dart';
import 'package:news_feed/models/post_model.dart';

class AddComment extends StatefulWidget {
  AddComment({this.focus, this.post});

  final bool focus;
  final PostModel post;

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  CommentModel comments = CommentModel();
  var _key = GlobalKey<FormState>();
  String newComment;
  bool showLoading = false;

  void _addAComment() async {
    setState(() => showLoading = true);
    await comments.addNewComment(postId: widget.post.postId, comment: newComment).whenComplete(() {
      setState(() => showLoading = false);
      _key.currentState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Form(
              key: _key,
              child: Container(
                height: 55.0,
                child: TextFormField(
                  autofocus: widget.focus,
                  keyboardType: TextInputType.multiline,
                  onChanged: (input) => setState(() => newComment = input),
                  decoration: InputDecoration(
                    hintText: 'Add a comment',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).appBarTheme.color,
                        width: 2,
                      ),
                    ),
                    fillColor: Theme.of(context).appBarTheme.color,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Theme.of(context).appBarTheme.color,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 55.0,
              margin: EdgeInsets.only(left: 4.0, right: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Theme.of(context).appBarTheme.color,
              ),
              child: IconButton(
                icon: showLoading == false
                    ? Icon(Icons.send, color: Theme.of(context).accentColor)
                    : SpinKitChasingDots(color: Theme.of(context).accentColor),
                onPressed: _addAComment,
              ),
            ),
          )
        ],
      ),
    );
  }
}
