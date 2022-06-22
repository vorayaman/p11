import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void Singup(
    String e1,
    String p1,
  ) {
    _auth.createUserWithEmailAndPassword(email: e1, password: p1);
  }

  void Singin(String e1, String p1, BuildContext context) {
    _auth.signInWithEmailAndPassword(email: e1, password: p1).whenComplete(() => Navigator.pushNamed(context, '/home'));
  }

  bool currentUser(BuildContext context) {
    if (_auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  void signOut(BuildContext context) {
    _auth.signOut().whenComplete(
          () => Navigator.pushNamed(context, '/'),
        );
  }

  void googleSingIn(BuildContext context)
  async{
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    GoogleSignInAuthentication gsa =await googleSignInAccount!.authentication;

    var credatial =GoogleAuthProvider.credential(accessToken: gsa.accessToken,idToken: gsa.idToken);


    _auth.signInWithCredential(credatial).whenComplete(() => Navigator.pushNamed(context, '/home'));
  }

}
