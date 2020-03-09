import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/Constant/CustomTextField.dart';
import 'package:news_feed/Screens/authencation/SignIn.dart';

class Register extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Register> {
  // an object of auth class
  Auth _auth = Auth();

  // a global key for the form
  final formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  String _name;
  String _email;
  String _password;

  // the message whene the user facing an error
  String errorMessage = '';

  // decide wither show the loading widget or not
  bool show = false;

  File imageFile;

  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 44.0),
        child: SafeArea(
          child: Form(
            key: formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // SizedBox(height: 35.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Text(
                      'Create \nAccount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
                FlatButton(
                  child: CircleAvatar(
                    radius: 55.0,
                    backgroundColor: Colors.blue,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: imageUrl != null
                            ? Image.file(
                                imageFile,
                                fit: BoxFit.fill,
                              )
                            : Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                                size: 50.0,
                              ),
                      ),
                    ),
                  ),
                  onPressed: () => getimage(),
                ),
                SizedBox(height: 35),
                CustomTextField(
                  onSaved: (input) => _name = input,
                  validator: (input) => input.isEmpty ? '*Required' : null,
                  icon: Icon(Icons.person),
                  obsecure: false,
                  hint: 'NAME',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onSaved: (input) => _email = input,
                  validator: (input) => input.isEmpty ? '*Required' : null,
                  icon: Icon(Icons.email),
                  obsecure: false,
                  hint: 'EMAIL',
                ),
                SizedBox(height: 20),
                CustomTextField(
                  onSaved: (input) => _password = input,
                  validator: (input) => input.isEmpty ? '*Required' : null,
                  icon: Icon(Icons.lock),
                  obsecure: true,
                  hint: 'Password',
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      highlightElevation: 0.0,
                      elevation: 0.0,
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                        bottom: 12,
                        top: 12,
                        left: 34,
                        right: 34,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn())),
                    ),
                    RaisedButton(
                      highlightElevation: 0.0,
                      elevation: 0.0,
                      color: Colors.blue,
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 34,
                        right: 34,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: show
                          ? SpinKitWave(color: Colors.white, size: 20)
                          : Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() => show = true);
                          dynamic result = await _auth.register(
                            _name,
                            _email,
                            _password,
                            imageUrl,
                          );
                          uploadFile();
                          if (result == null) {
                            setState(() => show = false);
                            errorMessage =
                                'Please Enter A Valid Email And Password..';
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getimage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        print(imageFile);
        imageUrl = imageFile.hashCode.toString();
        print(imageUrl);
      });
    }
  }

  Future uploadFile() async {
    String fileName = imageUrl.hashCode.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() => show = false);
    }, onError: (err) {
      setState(() => show = false);
      Fluttertoast.showToast(msg: 'faild to select an image');
    });
  }
}
