import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String displayName;
  bool exists = false;
  final Firestore _db = Firestore.instance;

  User.fromUid(FirebaseUser user){
    this.uid = user.uid;
    this.displayName = user.displayName;
    this.exists = true;
  }

  void getQuickNotes(){

  }

  void updateQuickNotes(){

  }

  void getLists(){

  }

  void updateList(){

  }
  
  
}

