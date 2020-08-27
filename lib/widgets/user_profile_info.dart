import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/User.dart';

class UserProfileInfo extends StatelessWidget {
  const UserProfileInfo({@required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 18.0),
        Center(
          child: SizedBox(
            height: 75.0,
            width: 75.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user?.photoUrl ?? 'https://fakeimg.pl/350x200/?text=World&font=lobster',
              ),
              radius: 24.0,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(user?.name ?? ''),
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(user?.email ?? ''),
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
      ],
    );
  }
}
