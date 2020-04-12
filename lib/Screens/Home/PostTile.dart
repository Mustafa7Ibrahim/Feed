import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_feed/Screens/Post/OpenPost.dart';
import 'package:news_feed/Screens/Profile/profile.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/widgets/post_image.dart';

class PostTile extends StatelessWidget {
  final Post post;
  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(post.userProfileImg),
          ),
          title: Text(post.userName),
          subtitle: Text(post.timeStamp),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(postUserId: post.ownerId),
              ),
            );
          },
        ),
        postSection(context),
        rowButtons(context),
      ],
    );
  }

  postSection(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenPost(
              post: post,
              focus: false,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          post.mediaUrl != null
              ? PostImage(imageUrl: post.mediaUrl)
              : Container(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              post.description,
              maxLines: 5,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  rowButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.thumbsUp),
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.comments),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenPost(
                    post: post,
                    focus: true,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
