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
        userInfo(context),
        postSection(context),
        rowButtons(context),
      ],
    );
  }

  ListTile userInfo(BuildContext context) {
    return ListTile(
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              post.description,
              maxLines: 5,
              softWrap: true,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          post.mediaUrl != null
              ? PostImage(imageUrl: post.mediaUrl)
              : Container(),
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
            icon: Icon(
              FontAwesomeIcons.thumbsUp,
              color: Colors.grey[400],
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.comments,
              color: Colors.grey[400],
            ),
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
