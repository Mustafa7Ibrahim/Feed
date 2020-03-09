import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  // final String id;
  // final String name;
  // NewPost({@required this.id, @required this.name});

  @override
  _NewPostState createState() => _NewPostState(
      // id: id, name: name
      );
}

class _NewPostState extends State<NewPost> {
  // _NewPostState({@required this.id, @required this.name});

  final _formKey = GlobalKey<FormState>();

  String newPost;
  // String name;
  // String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('username should show here'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Enter your Post'),
                onChanged: (input) => setState(() => newPost = input),
              ),
            ),
            RaisedButton(
              child: Text('Post', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.blue,
              onPressed: () async {
                // await postCollection.uploadPost(
                //     content: newPost, name: userdata.name
                //     );
              },
            )
          ],
        ),
      ),
    );
  }
}
