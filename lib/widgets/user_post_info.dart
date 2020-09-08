import 'package:flutter/material.dart';
import 'package:news_feed/Screens/Profile/profile.dart';
import 'package:news_feed/models/post_model.dart';

class UserPostInfo extends StatelessWidget {
  const UserPostInfo({@required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.userProfileImg)),
            title: Text(post.userName),
            subtitle: Text(post.timeStamp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(postUserId: post.ownerId, currentUser: false),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
