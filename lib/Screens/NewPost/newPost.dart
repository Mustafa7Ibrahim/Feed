import 'dart:io';

import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 24.0,
                  bottom: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      child: Icon(Icons.arrow_back_ios),
                      alignment: AlignmentDirectional.centerStart,
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage('assets/back.jpg'),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      _user.name ?? 'null',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
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
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  maxLines: 16,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Enter your Post',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 3,
                      ),
                    ),
                  ),
                  onChanged: (input) => setState(() => newPost = input),
                ),
              ),
              RaisedButton(
                child: Text('Post', style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.blue,
                onPressed: () async => await post.addNewPost(
                  description: newPost,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
