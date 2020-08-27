import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_feed/Constant/constant.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:news_feed/widgets/user_profile_info.dart';

import '../../widgets/PostTile.dart';

class Profile extends StatefulWidget {
  final String postUserId;
  final bool currentUser;
  Profile({@required this.postUserId, @required this.currentUser});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController controller = ScrollController();
  User user = User();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userCollection.document(widget.postUserId).snapshots().map(user.getUserData),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: widget.currentUser == true ? Container() : BackButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
            body: ListView(
              children: <Widget>[
                SizedBox(height: 24.0),
                UserProfileInfo(user: snapshot.data),
                userPosts(context, snapshot.data)
              ],
            ),
          );
        } else {
          return SpinKitFoldingCube(
            color: Theme.of(context).primaryColor,
            size: 24.0,
          );
        }
      },
    );
  }

  userPosts(BuildContext context, User user) {
    return StreamBuilder(
      stream: Post().getPosts,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return user.userId == snapshot.data[index].ownerId
                      ? PostTile(post: snapshot.data[index])
                      : Container();
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
