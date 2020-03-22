import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();

  final Post post = Post();

  String newPost;

  File image;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16.0,
                  backgroundImage: NetworkImage(_user.photoUrl),
                ),
                SizedBox(width: 8.0),
                Text(
                  _user.name ?? 'null',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 12.0),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'ADD NEW POST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              ClipRect(
                child: (image != null)
                    ? Image.file(image, fit: BoxFit.fill)
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  maxLines: 16,
                  minLines: 5,
                  onChanged: (input) => setState(() => newPost = input),
                  decoration: InputDecoration(
                    hintText: 'Enter your Post',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.blueGrey,
                onPressed: () async => await post
                    .addNewPost(description: newPost)
                    .whenComplete(() {
                  Fluttertoast.showToast(msg: 'Post Add Sucsessful');
                  Navigator.pop(context);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
