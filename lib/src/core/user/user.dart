import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String displayName;
  
  User({this.uid, this.displayName});

  User.fromFirebaseUser(FirebaseUser user) {
    if(user == null){
      this.uid = null;
      this.displayName = null;
    }
    this.uid = user.uid;
    this.displayName = user.displayName;
  }
}
