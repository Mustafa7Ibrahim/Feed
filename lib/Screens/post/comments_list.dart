import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/models/comment_model.dart';
import 'package:news_feed/models/post_model.dart';
import 'package:news_feed/Constant/constant.dart';

import 'comment_card.dart';

class CommentsList extends StatefulWidget {
  final focus;
  final PostModel thisPost;

  final ScrollController scrollController;

  CommentsList({this.thisPost, this.scrollController, this.focus});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final _key = GlobalKey<FormState>();

  String newComment;

  bool showLoading = false;

  CommentModel comment = CommentModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        addnewComment(),
        StreamBuilder(
          stream: postCollection
              .doc(widget.thisPost.postId)
              .collection('comments')
              .orderBy('timeStamp', descending: true)
              .snapshots()
              .map(comment.commentsList),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 70.0),
                height: 54.0,
                child: Center(
                  child: Text('No Comments'),
                ),
              );
            }
            if (snapshot.hasError) {
              return Container(
                margin: EdgeInsets.only(top: 70.0),
                height: 54.0,
                child: Center(
                  child: Text('oh! no! we got erroe ${snapshot.error}'),
                ),
              );
            }
            return Container(
              color: Theme.of(context).appBarTheme.color,
              margin: EdgeInsets.only(top: 110.0),
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CommentCard(comment: snapshot.data[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  addnewComment() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: ListView(
        controller: widget.scrollController,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          Row(
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
                        hintText: 'Enter Your Comment',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
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
                    color: Theme.of(context).accentColor,
                  ),
                  child: IconButton(
                    icon: showLoading == false
                        ? Icon(Icons.send, color: Colors.white)
                        : SpinKitChasingDots(
                            color: Theme.of(context).accentColor,
                          ),
                    onPressed: () async {
                      setState(() => showLoading = true);
                      await comment
                          .addNewComment(
                        postId: widget.thisPost.postId,
                        comment: newComment,
                      )
                          .then((done) {
                        setState(() => showLoading = false);
                        _key.currentState.reset();
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
