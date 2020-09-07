import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_feed/Screens/Wrapper.dart';
import 'package:news_feed/models/user_model.dart';
import 'package:news_feed/screens/sign_in/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  // uid String
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserModel _userModel = UserModel();

  Future<UserModel> signInWithGoogleSignIn(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn().catchError(
            (onError) => Fluttertoast.showToast(
              msg: 'Please Make sure that you have working internet.',
            ),
          );
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential _userCredential = await _auth.signInWithCredential(credential);

      final User _user = _userCredential.user;

      assert(_user.displayName != null);
      assert(_user.email != null);
      assert(_user.photoURL != null);

      final name = _user.displayName;
      final email = _user.email;
      final imageUrl = _user.photoURL;
      final id = _user.uid;

      _userModel.addNewUser(id, name, email, imageUrl);

      print(name);
      print(email);

      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(_user.uid == currentUser.uid);

      preferences.setString('user', currentUser.displayName);
      preferences.setString('userId', currentUser.uid);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper(userId: currentUser.uid)),
      );

      return _userModel.getCurrentUser(currentUser);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Please Make sure that you have working internet.',
      );
      return _userModel.getCurrentUser(null);
    }
  }

  //sign out
  signOutGoogle(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      await googleSignIn.signOut().catchError((onError) {
        print(onError.toString());
        Fluttertoast.showToast(msg: 'User Unsuccessfuly Signed Out');
      }).whenComplete(() {
        preferences.remove('user');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      });

      Fluttertoast.showToast(msg: 'User Successfuly Signed Out');

      print("User Sign Out");
    } catch (e) {
      Fluttertoast.showToast(msg: 'Sign Out Failed, Please try agein');
    }
  }
}
