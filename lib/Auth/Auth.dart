import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
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
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
