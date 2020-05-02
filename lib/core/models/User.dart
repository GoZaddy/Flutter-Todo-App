import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String displayName;
  bool exists;

  
  User({this.uid, this.displayName, this.exists});

  User.fromUid(FirebaseUser user) {
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.exists = true;
  }
}
