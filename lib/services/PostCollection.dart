import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_feed/Auth/Auth.dart';
import 'package:news_feed/models/Post.dart';

class PostCollection {
  Auth _auth = Auth();

  // collection refrence
  final CollectionReference postCollection =
      Firestore.instance.collection('Posts');

  Future uploadPost({String name, String content, String imageUrl}) async {
    return await postCollection.document(_auth.userId).setData({
      'name': name,
      'content': content,
      'imageUrl': imageUrl,
    });
  }

  List<Post> _postList(QuerySnapshot snapshot) {
    return snapshot.documents.map((postDoc) {
      return Post(
        name: postDoc.data['name'] ?? '',
        content: postDoc.data['content'] ?? '',
        imageUrl: postDoc.data['imageUrl'] ?? '',
      );
    }).toList();
  }

  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postList);
  }
}
