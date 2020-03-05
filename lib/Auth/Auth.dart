import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_feed/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  // a constructor of the class
  Auth({this.userId});

  // uid String
  final String userId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser currentUser;
  SharedPreferences sharedPreferences;

  // an instance of firestore
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // Register a new account using an email and password
  Future register(String name, String email, String password) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();

      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseUser user = result.user;
      if (user != null) {
        final QuerySnapshot result = await usersCollection
            .where('id', isEqualTo: user.uid)
            .getDocuments();

        final List<DocumentSnapshot> documents = result.documents;

        // checking if it's a new user
        if (documents.length == 0) {
          // upload his data
          await usersCollection.document(userId).setData({
            'id': user.uid,
            'name': name,
            'email': email,
            'photoUrl': user.photoUrl,
          });

          // write it's data to local storage
          currentUser = user;
          await sharedPreferences.setString('id', currentUser.uid);
          await sharedPreferences.setString('name', name);
          await sharedPreferences.setString('email', currentUser.email);
          await sharedPreferences.setString('photoUrl', currentUser.photoUrl);

          // this is just for testing
          print(sharedPreferences.getString('id'));
          print(sharedPreferences.getString('name'));
          print(sharedPreferences.getString('email'));
          print(sharedPreferences.getString('photoUrl'));
        }
        // show this message if the register is successfull
        Fluttertoast.showToast(msg: 'Registered successfuly');
      }
      // return the current user into user from firebase function
      return _userFromFirebaseUser(user);
    } catch (e) {

      print(e.toString());

      // return this message if the regester faild
      return Fluttertoast.showToast(msg: 'Registerd Faild : ${e.toString()}');
    }
  }

  // Sign in with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;

      if (user != null) {
        final QuerySnapshot result = await usersCollection
            .where('id', isEqualTo: user.uid)
            .getDocuments();
        final List<DocumentSnapshot> documents = result.documents;

        if (documents.length == 0) {
          // write it's data to local storage
          currentUser = user;
          await sharedPreferences.setString('id', currentUser.uid);
          await sharedPreferences.setString('name', currentUser.displayName);
          await sharedPreferences.setString('email', currentUser.email);
          await sharedPreferences.setString('photoUrl', currentUser.photoUrl);

          // this is just for testing
          print(sharedPreferences.getString('id'));
          print(sharedPreferences.getString('name'));
          print(sharedPreferences.getString('email'));
          print(sharedPreferences.getString('photoUrl'));
        }

        // show this message if the register is successfull
        Fluttertoast.showToast(msg: 'Sign in success');
      }
      return _userFromFirebaseUser(user);
    } catch (e) {

      print(e.toString());

      // return this message if the regester faild
      return Fluttertoast.showToast(msg: 'Registerd Faild : ${e.toString()}');
    }
  }

  // create user object based on firebase User that come from register function
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  // auth chanage user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign out method
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
