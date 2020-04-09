import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Screens/userProfile/userProfilePosts.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: controller,
          children: <Widget>[
            userInfo(context),
            userPosts(context),
          ],
        ),
      ),
    );
  }

  userInfo(BuildContext context) {
    final user = Provider.of<User>(context) ?? null;
    return Column(
      children: <Widget>[
        SizedBox(height: 18.0),
        Center(
          child: SizedBox(
            height: 75.0,
            width: 75.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user?.photoUrl ??
                    'https://fakeimg.pl/350x200/?text=World&font=lobster',
              ),
              radius: 24.0,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(
            user?.name ?? ''
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(
            user?.email ?? ''
          
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: IconButton(
                color: Colors.green[300],
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {
                  //TODO send message
                },
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
                onPressed: () {
                  // TODO open facebook app page
                },
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
                onPressed: () {
                  // TODO open linkedIn page
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  userPosts(BuildContext context) {
    final user = Provider.of<User>(context);
    final post = Provider.of<List<Post>>(context);
    return StreamBuilder(
      stream: Post().getPosts,
      builder: (context, snapshot) {
        return ListView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: post.length,
          itemBuilder: (context, index) {
            return UserProfilePosts(
              post: post[index],
              user: user,
            );
          },
        );
      },
    );
  }
}
