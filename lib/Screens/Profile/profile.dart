import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(54.0),
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/profile.jpg'),
                        fit: BoxFit.cover),
                  ),
                  height: 144.0,
                  width: 100.0,
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  memberInfo(),
                  about(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget memberInfo() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          'Stelle Kane',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
        ),
        SizedBox(height: 10.0),
        Text(
          'HR leader - Computer science',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.sms),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.facebookSquare),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.linkedin),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget about() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'About Member',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'A doctor is someone who maintains or restores human health through the practice of medicine.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Skils',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
