import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PostImage extends StatelessWidget {
  final imageUrl;
  PostImage({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent loadingProgress,
        ) {
          return loadingProgress == null
              ? child
              : Center(
                  child: SpinKitFoldingCube(
                    color: Theme.of(context).primaryColor,
                    size: 18.0,
                  ),
                );
        },
      ),
    );
  }
}
