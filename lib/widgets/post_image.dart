import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostImage extends StatelessWidget {
  final imageUrl;
  PostImage({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.0),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          return loadingProgress == null
              ? child
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpinKitFoldingCube(
                      color: Theme.of(context).accentColor,
                      size: 18.0,
                    ),
                    SizedBox(width: 14.0),
                    Text('Loading Image...'),
                  ],
                );
        },
      ),
    );
  }
}
