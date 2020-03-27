import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_feed/Screens/SignIn/SignIn.dart';
import 'package:news_feed/models/User.dart';

class Auth {
  String name;
  String email;
  String imageUrl;
  String id;

  // uid String
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User _user = User();

  Future<User> signInWithGoogleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn().catchError((onError) {
        print('onError');
        Fluttertoast.showToast(
            msg:
                'Please Make sure that you have working conection to the internet.');
      });
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(user.displayName != null);
      assert(user.email != null);
      assert(user.photoUrl != null);

      final name = user.displayName;
      final email = user.email;
      final imageUrl = user.photoUrl;
      final id = user.uid;

      _user.addNewUser(id, name, email, imageUrl);

      print(name);
      print(email);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return _user.getCurrentUser(currentUser);
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              'Please Make sure that you have working conection to the internet.');
      return _user.getCurrentUser(null);
    }
  }

  signOutGoogle(BuildContext context) async {
    try {
      await googleSignIn.signOut().catchError((onError) {
        print(onError.toString());
        Fluttertoast.showToast(msg: 'User Successfuly Signed Out');
      }).whenComplete(
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        ),
      );

      Fluttertoast.showToast(msg: 'User Successfuly Signed Out');

      print("User Sign Out");
    } catch (e) {
      Fluttertoast.showToast(msg: 'Sign Out Failed, Please try agein');
    }
  }
}
