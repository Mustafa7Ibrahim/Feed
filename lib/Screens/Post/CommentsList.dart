import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Screens/Post/CommentCard.dart';
import 'package:news_feed/models/Comment.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/Constant/constant.dart';

class CommentsList extends StatefulWidget {
  final focus;
  final Post thisPost;

  final ScrollController scrollController;

  CommentsList({this.thisPost, this.scrollController, this.focus});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final _key = GlobalKey<FormState>();

  String newComment;

  bool showLoading = false;

  Comment comment = Comment();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        addnewComment(),
        StreamBuilder(
          stream: postCollection
              .document(widget.thisPost.postId)
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
        color: Colors.white,
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
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Theme.of(context).primaryColor,
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
                      initialValue: null,
                      autofocus: widget.focus,
                      keyboardType: TextInputType.multiline,
                      onChanged: (input) => setState(() => newComment = input),
                      decoration: InputDecoration(
                        hintText: 'Enter Your Comment',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
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
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: showLoading == false
                        ? Icon(Icons.send)
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
