import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';

import 'profilePostTile.dart';

class Profile extends StatefulWidget {
  final String postUserId;
  Profile({this.postUserId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController controller = ScrollController();
  User user = User();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userCollection
          .document(widget.postUserId)
          .snapshots()
          .map(user.getUserData),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data.name),
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back),
            //   onPressed: () => Navigator.pop(context),
            // ),
          ),
          body: ListView(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data.photoUrl ??
                          'https://fakeimg.pl/350x200/?text=World&font=lobster',
                    ),
                    radius: 24.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(snapshot.data.name),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(snapshot.data.email),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: IconButton(
                      color: Colors.green[300],
                      icon: Icon(FontAwesomeIcons.sms),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      color: Colors.blueAccent,
                      icon: Icon(FontAwesomeIcons.facebookSquare),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      color: Colors.blue,
                      icon: Icon(FontAwesomeIcons.linkedin),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              userPosts(context, snapshot.data)
            ],
          ),
        );
      },
    );
  }

  userPosts(BuildContext context, User user) {
    // final post = Provider.of<List<Post>>(context);
    return StreamBuilder(
      stream: Post().getPosts,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ProfilePostTile(
                    post: snapshot.data[index],
                    user: user,
                  );
                },
              )
            : Center(
                child: SpinKitFoldingCube(
                  color: Theme.of(context).primaryColor,
                  size: 24.0,
                ),
              );
      },
    );
  }
}
