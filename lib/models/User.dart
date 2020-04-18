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

  List<DocumentSnapshot> getQuickNotes(){
    _db.collection("quickNotes").document(uid).collection("userNotes").snapshots().listen(
      (snapshot){
        return snapshot.documents;
      }
    );
  }

  void updateQuickNotes(){

  }

  void getLists(){
    _db.collection("lists").document(uid).collection("userLists").snapshots().listen(
      (snapshot){
        return snapshot.documents;
      }
    );
  }

  void updateList(){

  }

  void getList(){
    
  }
  
  
}

