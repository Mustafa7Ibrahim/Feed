import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class AddNewPost extends StatefulWidget {
  @override
  _AddNewPostState createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final Post post = Post();

  String newPost;

  String imageUrl;

  File imageFile;

  bool showLoadingImage = false;
  bool showLoadingPost = false;

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ADD NEW POST'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            userInfo(context),
            Column(
              children: <Widget>[
                SizedBox(height: 12.0),
                Container(
                  margin: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: TextField(
                    scrollPadding: EdgeInsets.all(14.0),
                    controller: _controller,
                    maxLines: 8,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    onChanged: (input) => setState(() => newPost = input),
                    decoration: InputDecoration(
                      hintText: 'Enter your Post',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(width: 1,color: Theme.of(context).primaryColor,),
                      ),
                    ),
                  ),
                ),
                addImage(context),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: showLoadingPost == false
            ? Icon(Icons.add)
            : SpinKitFoldingCube(color: Theme.of(context).accentColor, size: 12.0),
        onPressed: () async {
          if (newPost != null) {
            setState(() => showLoadingPost = true);
            if (imageUrl != null) {
              await uploadImage().then((onComplet) async {
                await post
                    .addNewPost(description: newPost, mediaUrl: imageUrl)
                    .then((onComplete) {
                  print(imageUrl);
                  setState(() => showLoadingPost = false);
                  Fluttertoast.showToast(msg: 'Post add Successfuly.');
                });
              });
            } else {
              await post.addNewPost(description: newPost).whenComplete(() {
                setState(() => showLoadingPost = false);
                Fluttertoast.showToast(msg: 'Post add Successfuly.');
              });
            }
          } else {
            Fluttertoast.showToast(msg: 'Please Type Something');
          }
        },
      ),
    );
  }

  userInfo(BuildContext context) {
    final _user = Provider.of<User>(context);

    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.0,
            backgroundImage: NetworkImage(
              _user?.photoUrl ??
                  'https://fakeimg.pl/350x200/?text=World&font=lobster',
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            _user?.name ?? 'User Name',
            // style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(width: 12.0),
        ],
      ),
    );
  }

  addImage(BuildContext context) {
    return FlatButton(
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        child: SizedBox(
          height: 300,
          child: ClipRect(
            child: (imageUrl != null)
                ? Image.file(
                    imageFile,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  )
                : (showLoadingImage == false)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add),
                          SizedBox(width: 4.0),
                          Text('Add Photo'),
                        ],
                      )
                    : SpinKitFoldingCube(color: Theme.of(context).accentColor),
          ),
        ),
      ),
      onPressed: () => getImageUrl(),
    );
  }

  Future getImageUrl() async {
    setState(() => showLoadingImage = true);
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery)
        .whenComplete(() => setState(() => showLoadingImage = false));
    if (imageFile != null) {
      setState(() => imageUrl = imageFile.hashCode.toString());
    }
  }

  Future uploadImage() async {
    String fileName = imageUrl;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    dynamic url = await taskSnapshot.ref.getDownloadURL();
    if (url != null) {
      setState(() {
        imageUrl = url;
        showLoadingImage = false;
      });
      print(imageUrl);
      Fluttertoast.showToast(msg: 'Upload image Complete');
    } else {
      setState(() => showLoadingImage = false);
      Fluttertoast.showToast(msg: 'Upload image faild');
    }
  }
}
